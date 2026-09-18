enum MessageRole { user, assistant }

class ChatMessage {
  const ChatMessage({
    this.id,
    this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  final int? id;
  final int? conversationId;
  final MessageRole role;
  final String content;
  final DateTime createdAt;
}
