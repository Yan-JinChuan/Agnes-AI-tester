import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/features/generation/presentation/viewmodels/image_generation_view_model.dart';
import 'package:agnes_ai_tester/src/features/generation/presentation/widgets/generation_widgets.dart';
import 'package:agnes_ai_tester/src/features/generation/presentation/widgets/image_generation_widgets.dart';

import '../../../../core/cache/app_media_cache.dart';
import '../../../../core/config/app_config_provider.dart';

/// View for image generation. State and commands are owned by the ViewModel.
class ImageGenerationView extends ConsumerStatefulWidget {
  const ImageGenerationView({super.key});

  @override
  ConsumerState<ImageGenerationView> createState() =>
      _ImageGenerationViewState();
}

class _ImageGenerationViewState extends ConsumerState<ImageGenerationView> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(
      () => ref.read(imageGenerationViewModelProvider.notifier).loadHistory(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageGenerationViewModelProvider);
    final config = ref.watch(appConfigProvider);
    final cache = ref.watch(appMediaCacheProvider);
    final viewModel = ref.read(imageGenerationViewModelProvider.notifier);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GenerationModuleIntro(
                icon: Icons.image_outlined,
                title: '图片生成',
                description: '使用文字描述生成一张图片，结果会直接显示在这里。',
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '当前模型：${config.imageModel}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: state.prompt,
                        minLines: 3,
                        maxLines: 7,
                        onChanged: viewModel.setPrompt,
                        decoration: const InputDecoration(
                          labelText: '图片提示词',
                          hintText: '例如：雨夜霓虹灯下的未来城市，电影感，细节丰富',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.edit_note_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: state.size,
                              decoration: const InputDecoration(
                                labelText: '输出尺寸',
                                prefixIcon: Icon(Icons.aspect_ratio_outlined),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: '1024x1024',
                                  child: Text('1024 × 1024（方形）'),
                                ),
                                DropdownMenuItem(
                                  value: '1024x768',
                                  child: Text('1024 × 768（横向）'),
                                ),
                                DropdownMenuItem(
                                  value: '768x1024',
                                  child: Text('768 × 1024（纵向）'),
                                ),
                              ],
                              onChanged: state.isLoading
                                  ? null
                                  : (value) {
                                      if (value != null) {
                                        viewModel.setSize(value);
                                      }
                                    },
                            ),
                          ),
                          const SizedBox(width: 14),
                          FilledButton.icon(
                            onPressed: state.isLoading
                                ? null
                                : viewModel.generate,
                            icon: state.isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.auto_awesome),
                            label: Text(state.isLoading ? '生成中…' : '生成图片'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 16),
                GenerationError(
                  message: state.error!,
                  onDismiss: viewModel.dismissError,
                ),
              ],
              if (state.result != null) ...[
                const SizedBox(height: 24),
                ImageResultCard(record: state.result!, cache: cache),
              ],
              if (state.history.isNotEmpty) ...[
                const SizedBox(height: 28),
                ImageHistoryList(
                  history: state.history,
                  cache: cache,
                  onSelect: viewModel.selectHistory,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
