import '../../domain/models/chat_message.dart';
import '../../domain/models/conversation_summary.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_data_source.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({
    required this.remote,
    required this.local,
    required this.model,
  });

  final ChatRemoteDataSource remote;
  final ChatLocalDataSource local;
  final String model;

  @override
  Future<List<ChatMessage>> loadMessages(int conversationId) async {
    final rows = await local.loadMessages(conversationId);
    return rows.map(_messageFromRow).toList();
  }

  @override
  Future<List<ConversationSummary>> loadConversations() async {
    final rows = await local.loadConversations();
    return rows
        .map(
          (row) => ConversationSummary(
            id: row['id'] as int,
            title: row['title'] as String? ?? '新对话',
            updatedAt: DateTime.fromMillisecondsSinceEpoch(
              row['updated_at'] as int,
            ),
          ),
        )
        .toList();
  }

  @override
  Future<int> createConversation(String firstPrompt) {
    final title = firstPrompt.trim().length > 30
        ? '${firstPrompt.trim().substring(0, 30)}…'
        : firstPrompt.trim();
    return local.createConversation(title);
  }

  @override
  Future<void> saveMessage(ChatMessage message, int conversationId) {
    return local.insertMessage(
      conversationId: conversationId,
      role: message.role == MessageRole.user ? 'user' : 'assistant',
      content: message.content,
      createdAt: message.createdAt,
    );
  }

  @override
  Future<String> completeChat(List<ChatMessage> messages) {
    return remote.completeChat(model: model, messages: messages);
  }

  ChatMessage _messageFromRow(Map<String, Object?> row) {
    return ChatMessage(
      id: row['id'] as int?,
      conversationId: row['conversation_id'] as int?,
      role: row['role'] == 'user' ? MessageRole.user : MessageRole.assistant,
      content: row['content'] as String? ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
    );
  }
}
