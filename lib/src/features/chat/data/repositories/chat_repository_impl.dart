import '../../../../core/network/api_exception.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/models/conversation_summary.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_data_source.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/chat_api_models.dart';

/// 协调聊天远程接口与本地存储，并在此处将数据库行转换为领域实体。
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({
    required this.remote,
    required this.local,
    required this.model,
  });

  final ChatRemoteDataSource remote;
  final ChatLocalDataSource local;
  final String model;

  /// 读取会话消息并转换为聊天领域实体。
  @override
  Future<List<ChatMessage>> loadMessages(int conversationId) async {
    final rows = await local.loadMessages(conversationId);
    return rows.map(_messageFromRow).toList();
  }

  /// 读取本地会话摘要，按数据源返回顺序保留最近会话优先级。
  @override
  Future<List<ConversationSummary>> loadConversations() async {
    final rows = await local.loadConversations();
    return rows
        .map(
          (row) => ConversationSummary(
            id: row.id,
            title: row.title,
            updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
          ),
        )
        .toList();
  }

  /// 用首条提示生成会话标题，并返回新会话的本地 id。
  @override
  Future<int> createConversation(String firstPrompt) {
    final title = firstPrompt.trim().length > 30
        ? '${firstPrompt.trim().substring(0, 30)}…'
        : firstPrompt.trim();
    return local.createConversation(title);
  }

  /// 将领域消息映射为存储字段并写入对应会话。
  @override
  Future<void> saveMessage(ChatMessage message, int conversationId) {
    return local.insertMessage(
      conversationId: conversationId,
      role: message.role == MessageRole.user ? 'user' : 'assistant',
      content: message.content,
      createdAt: message.createdAt,
    );
  }

  /// 请求聊天回复；接口未提供有效文本时转为统一网络异常。
  @override
  Future<String> completeChat(List<ChatMessage> messages) async {
    final response = await remote.completeChat(
      request: ChatCompletionRequest.fromDomain(
        model: model,
        messages: messages,
      ),
    );
    final content = response.textContent;
    if (content == null) {
      throw const ApiException(message: '接口返回成功，但回复内容为空。');
    }
    return content;
  }

  /// 将 Drift 行转换为聊天领域实体。
  ChatMessage _messageFromRow(ChatMessageRow row) {
    return ChatMessage(
      id: row.id,
      conversationId: row.conversationId,
      role: row.role == 'user' ? MessageRole.user : MessageRole.assistant,
      content: row.content,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }
}
