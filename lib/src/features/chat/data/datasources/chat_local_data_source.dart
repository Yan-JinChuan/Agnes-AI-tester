import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/app_database.dart';

part 'chat_local_data_source.g.dart';

/// 声明聊天会话与消息的本地类型化存取契约。
abstract interface class ChatLocalDataSource {
  /// 按时间顺序读取指定会话的消息。
  Future<List<ChatMessageRow>> loadMessages(int conversationId);

  /// 按最近更新时间倒序读取会话。
  Future<List<ConversationRow>> loadConversations();

  /// 规范化标题后创建会话，并返回数据库行 id。
  Future<int> createConversation(String title);

  /// 原子写入消息并更新时间，避免会话列表与消息历史不同步。
  Future<int> insertMessage({
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
  });

  /// 删除会话，由 Drift 外键级联删除关联消息。
  Future<void> deleteConversation(int conversationId);
}

/// 提供聊天本地数据源，并复用应用唯一的 Drift 数据库。
@riverpod
ChatLocalDataSource chatLocalDataSource(Ref ref) {
  return DriftChatLocalDataSource(database: ref.watch(appDatabaseProvider));
}

/// 使用 Drift 实现聊天本地存储契约。
class DriftChatLocalDataSource implements ChatLocalDataSource {
  /// 将聊天查询绑定到应用共享的 Drift 连接。
  const DriftChatLocalDataSource({required this.database});

  final AppDatabase database;

  @override
  Future<List<ChatMessageRow>> loadMessages(int conversationId) {
    return (database.select(database.messages)
          ..where((message) => message.conversationId.equals(conversationId))
          ..orderBy([
            (message) => OrderingTerm.asc(message.createdAt),
            (message) => OrderingTerm.asc(message.id),
          ]))
        .get();
  }

  @override
  Future<List<ConversationRow>> loadConversations() {
    return (database.select(database.conversations)..orderBy([
          (conversation) => OrderingTerm.desc(conversation.updatedAt),
        ]))
        .get();
  }

  @override
  Future<int> createConversation(String title) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    return database
        .into(database.conversations)
        .insert(
          ConversationsCompanion.insert(
            title: title.trim().isEmpty ? '新对话' : title.trim(),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<int> insertMessage({
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
  }) async {
    return database.transaction(() async {
      // 1. 在同一事务里写入消息和会话时间，避免历史顺序与会话列表脱节。
      final id = await database
          .into(database.messages)
          .insert(
            MessagesCompanion.insert(
              conversationId: conversationId,
              role: role,
              content: content,
              createdAt: createdAt.millisecondsSinceEpoch,
            ),
          );
      // 2. 与消息使用同一个事务推进会话列表的排序时间。
      await (database.update(
        database.conversations,
      )..where((conversation) => conversation.id.equals(conversationId))).write(
        ConversationsCompanion(
          updatedAt: Value(createdAt.millisecondsSinceEpoch),
        ),
      );
      return id;
    });
  }

  @override
  Future<void> deleteConversation(int conversationId) async {
    await (database.delete(
      database.conversations,
    )..where((conversation) => conversation.id.equals(conversationId))).go();
  }
}
