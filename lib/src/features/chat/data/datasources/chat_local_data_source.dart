import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/storage/app_database.dart';

part 'chat_local_data_source.g.dart';

abstract interface class ChatLocalDataSource {
  Future<List<Map<String, Object?>>> loadMessages(int conversationId);

  Future<List<Map<String, Object?>>> loadConversations();

  Future<int> createConversation(String title);

  Future<int> insertMessage({
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
  });

  Future<void> deleteConversation(int conversationId);
}

@riverpod
ChatLocalDataSource chatLocalDataSource(Ref ref) {
  final appDatabase = ref.watch(appDatabaseProvider);
  final database = appDatabase.database;
  return SqliteChatLocalDataSource(database: database);
}

class SqliteChatLocalDataSource implements ChatLocalDataSource {
  const SqliteChatLocalDataSource({required this.database});

  final Database database;

  @override
  Future<List<Map<String, Object?>>> loadMessages(int conversationId) async {
    return database.query(
      DataBaseTableNames.messages,
      where: 'conversation_id = ?',
      whereArgs: [conversationId],
      orderBy: 'created_at ASC, id ASC',
    );
  }

  @override
  Future<List<Map<String, Object?>>> loadConversations() async {
    return database.query(
      DataBaseTableNames.conversations,
      orderBy: 'updated_at DESC',
    );
  }

  @override
  Future<int> createConversation(String title) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    return database.insert(DataBaseTableNames.conversations, {
      'title': title.trim().isEmpty ? '新对话' : title.trim(),
      'created_at': now,
      'updated_at': now,
    });
  }

  @override
  Future<int> insertMessage({
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
  }) async {
    final id = await database.insert(DataBaseTableNames.messages, {
      'conversation_id': conversationId,
      'role': role,
      'content': content,
      'created_at': createdAt.millisecondsSinceEpoch,
    });
    await database.update(
      DataBaseTableNames.conversations,
      {'updated_at': createdAt.millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [conversationId],
    );
    return id;
  }

  @override
  Future<void> deleteConversation(int conversationId) async {
    await database.delete(
      DataBaseTableNames.conversations,
      where: 'id = ?',
      whereArgs: [conversationId],
    );
  }
}
