import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:agnes_ai_tester/src/core/utils/error_message.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/di/generation_data_providers.dart';
import '../../domain/models/image_generation_record.dart';
import '../../domain/repositories/image_repository.dart';

part 'image_generation_view_model.freezed.dart';
part 'image_generation_view_model.g.dart';

@freezed
class const ImageState({
  final String prompt = '',
  final String size = '1024x1024',
  final ImageGenerationRecord? result,
  final List<ImageGenerationRecord> history = const [],
  final bool isLoading = false,
  final String? error,
}) with _$ImageState;

@riverpod
class ImageGenerationViewModel extends _$ImageGenerationViewModel {
  late ImageRepository _repository;

  @override
  ImageState build() {
    ref.listen(imageRepositoryProvider, (_, repository) {
      _repository = repository;
    }, fireImmediately: true);
    return const ImageState();
  }

  void setPrompt(String prompt) {
    state = state.copyWith(prompt: prompt);
  }

  void setSize(String size) {
    state = state.copyWith(size: size);
  }

  Future<void> loadHistory() async {
    try {
      state = state.copyWith(history: await _repository.history());
    } catch (error) {
      state = state.copyWith(error: readableErrorMessage(error));
    }
  }

  Future<void> generate() async {
    final prompt = state.prompt.trim();
    if (state.isLoading || prompt.isEmpty) return;
    state = state.copyWith(isLoading: true, error: null, result: null);
    try {
      final result = await _repository.generate(
        prompt: prompt,
        size: state.size,
      );
      state = state.copyWith(
        result: result,
        history: [result, ...state.history],
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: readableErrorMessage(error),
      );
    }
  }

  void dismissError() {
    state = state.copyWith(error: null);
  }

  void selectHistory(ImageGenerationRecord record) {
    final isSelected =
        identical(state.result, record) ||
        (record.id != null && state.result?.id == record.id);
    state = state.copyWith(result: isSelected ? null : record, error: null);
  }

  /// Deletes a persisted image and closes it when it is the visible result.
  Future<void> deleteHistory(ImageGenerationRecord record) async {
    final id = record.id;
    if (id == null) {
      state = state.copyWith(error: '该图片记录尚未保存，无法删除。');
      return;
    }

    try {
      await _repository.delete(id: id);
      final wasSelected =
          identical(state.result, record) || state.result?.id == id;
      state = state.copyWith(
        history: state.history.where((item) => item.id != id).toList(),
        result: wasSelected ? null : state.result,
        error: null,
      );
    } catch (error) {
      state = state.copyWith(error: readableErrorMessage(error));
    }
  }
}
