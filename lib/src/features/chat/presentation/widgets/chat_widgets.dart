import 'package:flutter/material.dart';

import '../../domain/models/chat_message.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    required this.conversationId,
    required this.onHistory,
    required this.onNewConversation,
    super.key,
  });

  final int? conversationId;
  final VoidCallback onHistory;
  final VoidCallback? onNewConversation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 20, 4),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '文本聊天',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 4),
                Text('多轮对话会自动带上当前上下文。'),
              ],
            ),
          ),
          IconButton(
            tooltip: '历史对话',
            onPressed: onHistory,
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: '新建对话',
            onPressed: onNewConversation,
            icon: const Icon(Icons.add_comment_outlined),
          ),
          if (conversationId != null)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Chip(
                avatar: Icon(Icons.save_outlined, size: 16),
                label: Text('已保存'),
              ),
            ),
        ],
      ),
    );
  }
}

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.11),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.forum_outlined, color: primary, size: 36),
            ),
            const SizedBox(height: 20),
            const Text(
              '准备开始测试',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 9),
            Text(
              '配置 API Key 后发送一条消息。\n每轮对话会保存到 SQLite。',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.message, super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              const ChatAvatar(icon: Icons.auto_awesome, assistant: true),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: isUser ? scheme.primary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isUser ? 18 : 5),
                    bottomRight: Radius.circular(isUser ? 5 : 18),
                  ),
                  boxShadow: isUser
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: SelectableText(
                  message.content,
                  style: TextStyle(
                    color: isUser ? scheme.onPrimary : scheme.onSurface,
                    height: 1.5,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            if (isUser) ...[
              const SizedBox(width: 10),
              const ChatAvatar(icon: Icons.person_outline, assistant: false),
            ],
          ],
        ),
      ),
    );
  }
}

class ChatAvatar extends StatelessWidget {
  const ChatAvatar({required this.icon, required this.assistant, super.key});

  final IconData icon;
  final bool assistant;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: assistant
          ? Theme.of(context).colorScheme.primary
          : Colors.grey.shade300,
      child: Icon(
        icon,
        size: 18,
        color: assistant ? Colors.white : Colors.grey.shade700,
      ),
    );
  }
}

class ChatComposer extends StatelessWidget {
  const ChatComposer({
    required this.controller,
    required this.isLoading,
    required this.onSend,
    super.key,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: 5,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => onSend(),
        decoration: InputDecoration(
          hintText: isLoading ? 'Agnes 正在思考…' : '输入消息，按 Enter 发送',
          prefixIcon: const Icon(Icons.chat_bubble_outline),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: IconButton.filled(
              tooltip: '发送消息',
              onPressed: isLoading ? null : onSend,
              icon: const Icon(Icons.arrow_upward_rounded),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatErrorBanner extends StatelessWidget {
  const ChatErrorBanner({
    required this.message,
    required this.onDismiss,
    super.key,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: scheme.onErrorContainer, size: 19),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: scheme.onErrorContainer),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: '关闭提示',
            onPressed: onDismiss,
            icon: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }
}
