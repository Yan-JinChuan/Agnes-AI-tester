import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:agnes_ai_tester/src/core/utils/error_message.dart';

import '../../data/di/chat_data_providers.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/models/conversation_summary.dart';
import '../../domain/repositories/chat_repository.dart';

part 'chat_view_model.freezed.dart';
part 'chat_view_model.g.dart';

@freezed
class const ChatState({
  final int? conversationId,
  final List<ChatMessage> messages = const [],
  final bool isLoading = false,
  final String? error,
}) with _$ChatState;

@riverpod
class ChatViewModel extends _$ChatViewModel {
  late ChatRepository _repository;

  @override
  ChatState build() {
    // Update the repository when connection/model settings change without
    // resetting the conversation currently displayed by the user.
    ref.listen(chatRepositoryProvider, (_, repository) {
      _repository = repository;
    }, fireImmediately: true);
    return const ChatState();
  }

  Future<void> send(String prompt) async {
    if (state.isLoading || prompt.trim().isEmpty) return;

    final userMessage = ChatMessage(
      role: MessageRole.user,
      content: prompt.trim(),
      createdAt: DateTime.now(),
    );
    final history = [...state.messages, userMessage];
    state = state.copyWith(messages: history, isLoading: true, error: null);

    try {
      final conversationId =
          state.conversationId ?? await _repository.createConversation(prompt);
      state = state.copyWith(conversationId: conversationId);
      await _repository.saveMessage(userMessage, conversationId);

      final reply = await _repository.completeChat(history);
      final assistantMessage = ChatMessage(
        role: MessageRole.assistant,
        content: reply,
        createdAt: DateTime.now(),
      );
      await _repository.saveMessage(assistantMessage, conversationId);
      state = state.copyWith(
        messages: [...history, assistantMessage],
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: readableErrorMessage(error),
      );
    }
  }

  Future<void> loadConversation(int conversationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final messages = await _repository.loadMessages(conversationId);
      state = state.copyWith(
        conversationId: conversationId,
        messages: messages,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: readableErrorMessage(error),
      );
    }
  }

  Future<List<ConversationSummary>> listConversations() {
    return _repository.loadConversations();
  }

  void newConversation() {
    state = const ChatState();
  }

  void dismissError() {
    state = state.copyWith(error: null);
  }
}
