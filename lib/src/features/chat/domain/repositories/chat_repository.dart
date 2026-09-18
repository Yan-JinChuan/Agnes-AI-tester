import '../models/chat_message.dart';
import '../models/conversation_summary.dart';

abstract interface class ChatRepository {
  Future<List<ChatMessage>> loadMessages(int conversationId);

  Future<List<ConversationSummary>> loadConversations();

  Future<int> createConversation(String firstPrompt);

  Future<void> saveMessage(ChatMessage message, int conversationId);

  Future<String> completeChat(List<ChatMessage> messages);
}
