enum MessageRole { user, assistant }

class ChatMessage({
  final int? id,
  final int? conversationId,
  required final MessageRole role,
  required final String content,
  required final DateTime createdAt,
}) {}
