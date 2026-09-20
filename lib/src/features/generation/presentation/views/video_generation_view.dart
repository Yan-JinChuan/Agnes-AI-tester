import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/cache/app_media_cache.dart';
import '../../../../core/config/app_config_provider.dart';
import '../viewmodels/video_generation_view_model.dart';
import '../widgets/generation_widgets.dart';
import '../widgets/video_history_list.dart';
import '../widgets/video_job_card.dart';

/// View for video generation. It only binds controls to the ViewModel state.
class VideoGenerationView extends ConsumerStatefulWidget {
  const VideoGenerationView({super.key});

  @override
  ConsumerState<VideoGenerationView> createState() =>
      _VideoGenerationViewState();
}

class _VideoGenerationViewState extends ConsumerState<VideoGenerationView> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(
      () => ref.read(videoGenerationViewModelProvider.notifier).loadHistory(),
    );
  }

  void _create() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(videoGenerationViewModelProvider.notifier).create();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoGenerationViewModelProvider);
    final config = ref.watch(appConfigProvider);
    final cache = ref.watch(appMediaCacheProvider);
    final viewModel = ref.read(videoGenerationViewModelProvider.notifier);
    final currentRecord = state.currentRecord;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GenerationModuleIntro(
                  icon: Icons.movie_outlined,
                  title: '视频生成',
                  description: '提交后自动每 8 秒轮询一次，直到任务完成或失败。',
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '当前模型：${config.videoModel}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: state.prompt,
                          minLines: 3,
                          maxLines: 7,
                          onChanged: viewModel.setPrompt,
                          decoration: const InputDecoration(
                            labelText: '视频提示词',
                            hintText: '例如：镜头缓慢推进，一艘飞船穿过紫色星云',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.edit_note_outlined),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: 260,
                              child: DropdownButtonFormField<String>(
                                initialValue: state.dimensionPreset,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: '尺寸预设',
                                  prefixIcon: Icon(Icons.aspect_ratio_outlined),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'standard',
                                    child: Text('标准横向（1152 × 768）'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'landscape',
                                    child: Text('横向（1152 × 768）'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'portrait',
                                    child: Text('竖向（768 × 1152）'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'square',
                                    child: Text('方形（768 × 768）'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'fourThree',
                                    child: Text('4:3（1024 × 768）'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'threeFour',
                                    child: Text('3:4（768 × 1024）'),
                                  ),
                                ],
                                onChanged: state.isLoading
                                    ? null
                                    : viewModel.setDimensionPreset,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                initialValue: state.width,
                                onChanged: viewModel.setWidth,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'width',
                                  suffixText: 'px',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                initialValue: state.height,
                                onChanged: viewModel.setHeight,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'height',
                                  suffixText: 'px',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: 190,
                              child: TextFormField(
                                initialValue: state.numFrames,
                                onChanged: viewModel.setNumFrames,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'num_frames',
                                  helperText: '≤ 441 且为 8n+1',
                                ),
                                validator: (value) {
                                  final numFrames = int.tryParse(value ?? '');
                                  if (numFrames == null) return null;
                                  bool isValid = true;
                                  if (numFrames < 0 || numFrames > 441) isValid = false;
                                  if (numFrames % 8 != 1) isValid = false;
                                  return isValid ? null : '≤ 441 且为 8n+1';
                                },
                              ),
                            ),
                            SizedBox(
                              width: 190,
                              child: TextFormField(
                                initialValue: state.frameRate,
                                onChanged: viewModel.setFrameRate,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: const InputDecoration(
                                  labelText: 'frame_rate',
                                  helperText: '1–60 fps',
                                ),
                                validator: (value) {
                                  final frameRate = double.tryParse(value ?? '');
                                  if (frameRate == null) return null;
                                  bool isValid = true;
                                  if (frameRate < 1 || frameRate > 60) isValid = false;
                                  return isValid ? null : '1–60 fps';
                                },
                              ),
                            ),
                            SizedBox(
                              width: 260,
                              child: DropdownButtonFormField<String>(
                                initialValue: state.mode,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'mode（可选）',
                                  prefixIcon: Icon(Icons.tune_outlined),
                                ),
                                items: const [
                                  DropdownMenuItem(value: '', child: Text('默认')),
                                  DropdownMenuItem(
                                    value: 'ti2vid',
                                    child: Text('ti2vid（图生视频）'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'keyframes',
                                    child: Text('keyframes（关键帧）'),
                                  ),
                                ],
                                onChanged: state.isLoading
                                    ? null
                                    : viewModel.setMode,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: const Text('高级参数'),
                          subtitle: const Text('推理步数、种子、负向提示词、图生视频与关键帧'),
                          childrenPadding: const EdgeInsets.only(bottom: 4),
                          children: [
                            TextFormField(
                              initialValue: state.imageUrl,
                              onChanged: viewModel.setImageUrl,
                              keyboardType: TextInputType.url,
                              decoration: const InputDecoration(
                                labelText: 'image（可选）',
                                hintText: '公开可访问的图片 URL，用于图生视频',
                                prefixIcon: Icon(Icons.image_search_outlined),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: state.keyframeUrls,
                              onChanged: viewModel.setKeyframeUrls,
                              minLines: 2,
                              maxLines: 4,
                              keyboardType: TextInputType.url,
                              decoration: const InputDecoration(
                                labelText: 'extra_body.image（可选）',
                                hintText: '关键帧图片 URL，每行一个；填写后会自动使用 keyframes',
                                alignLabelWithHint: true,
                                prefixIcon: Icon(Icons.collections_outlined),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                SizedBox(
                                  width: 190,
                                  child: TextFormField(
                                    initialValue: state.numInferenceSteps,
                                    onChanged: viewModel.setNumInferenceSteps,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'num_inference_steps',
                                      hintText: '可选',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 190,
                                  child: TextFormField(
                                    initialValue: state.seed,
                                    onChanged: viewModel.setSeed,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'seed',
                                      hintText: '可选',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: state.negativePrompt,
                              onChanged: viewModel.setNegativePrompt,
                              minLines: 2,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'negative_prompt（可选）',
                                hintText: '不希望出现在视频中的内容',
                                alignLabelWithHint: true,
                                prefixIcon: Icon(Icons.block_outlined),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Agnes 会根据标准化分辨率和宽高比调整最终输出；实际 size、seconds 和 metadata.size_mapping 会显示在任务结果中。',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: state.isLoading ? null : _create,
                            icon: state.isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.movie_creation_outlined),
                            label: Text(state.isLoading ? '提交中…' : '提交视频任务'),
                          ),
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
                if (state.job != null && currentRecord != null) ...[
                  const SizedBox(height: 24),
                  VideoJobCard(
                    record: currentRecord,
                    cache: cache,
                    isLoading: state.isLoading,
                    onPoll: viewModel.poll,
                  ),
                ],
                if (state.history.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  VideoHistoryList(
                    history: state.history,
                    onSelect: viewModel.selectHistory,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
