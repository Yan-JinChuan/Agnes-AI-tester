import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/features/chat/presentation/viewmodels/chat_view_model.dart';
import 'package:agnes_ai_tester/src/features/chat/presentation/widgets/chat_widgets.dart';

/// Chat feature view. It renders state and delegates actions to [ChatViewModel].
class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final _promptController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) return;
    _promptController.clear();
    await ref.read(chatViewModelProvider.notifier).send(prompt);
    _scrollToBottom();
  }

  Future<void> _openHistory() async {
    try {
      final conversations = await ref
          .read(chatViewModelProvider.notifier)
          .listConversations();
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) {
          if (conversations.isEmpty) {
            return const SizedBox(
              height: 180,
              child: Center(child: Text('还没有保存的对话。')),
            );
          }
          return SafeArea(
            child: SizedBox(
              height: 420,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: conversations.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final conversation = conversations[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.chat_bubble_outline, size: 18),
                    ),
                    title: Text(
                      conversation.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(_formatDate(conversation.updatedAt)),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await ref
                          .read(chatViewModelProvider.notifier)
                          .loadConversation(conversation.id);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
      _scrollToBottom();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('读取历史对话失败，请检查本地数据库配置。')));
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatViewModelProvider);
    return Column(
      children: [
        ChatHeader(
          conversationId: state.conversationId,
          onHistory: _openHistory,
          onNewConversation: state.isLoading
              ? null
              : () =>
                    ref.read(chatViewModelProvider.notifier).newConversation(),
        ),
        Expanded(
          child: state.messages.isEmpty
              ? const ChatEmptyState()
              : ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  itemCount: state.messages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, index) =>
                      MessageBubble(message: state.messages[index]),
                ),
        ),
        if (state.error != null)
          ChatErrorBanner(
            message: state.error!,
            onDismiss: () =>
                ref.read(chatViewModelProvider.notifier).dismissError(),
          ),
        if (state.isLoading) const LinearProgressIndicator(minHeight: 2),
        ChatComposer(
          controller: _promptController,
          isLoading: state.isLoading,
          onSend: _send,
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  final local = date.toLocal();
  final datePart = [
    local.year.toString(),
    local.month.toString(),
    local.day.toString(),
  ].join('/');
  final timePart = [
    local.hour.toString().padLeft(2, '0'),
    local.minute.toString().padLeft(2, '0'),
  ].join(':');
  return [datePart, timePart].join(' ');
}
