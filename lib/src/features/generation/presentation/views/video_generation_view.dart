import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config_provider.dart';
import '../../domain/models/video_generation_options.dart';
import '../viewmodels/video_generation_view_model.dart';
import '../widgets/generation_widgets.dart';
import '../widgets/video_history_list.dart';
import '../widgets/video_job_card.dart';

/// Video generation form. The request shape follows the configured model.
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

  void _create(String model) {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ref.read(videoGenerationViewModelProvider.notifier).create(model: model);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoGenerationViewModelProvider);
    final config = ref.watch(appConfigProvider);
    final viewModel = ref.read(videoGenerationViewModelProvider.notifier);
    final currentRecord = state.currentRecord;
    final isModern = isAgnesVideo25OrLater(config.videoModel);

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
                GenerationModuleIntro(
                  icon: Icons.movie_outlined,
                  title: '视频生成',
                  description: isModern
                      ? '当前使用 Video 2.5：支持文生视频、首尾帧控制和多模态参考生成。'
                      : '当前使用兼容流程：提交后自动轮询任务，直到完成或失败。',
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
                            hintText: '描述主体、动作、场景、镜头、光线和风格',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.edit_note_outlined),
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? '请输入视频提示词'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        if (isModern)
                          _ModernVideoForm(state: state, viewModel: viewModel)
                        else
                          _LegacyVideoForm(state: state, viewModel: viewModel),
                        const SizedBox(height: 12),
                        Text(
                          isModern
                              ? 'Video 2.5 的媒体链接必须是 Agnes AI 可公开访问的 URL；任务完成后以 metadata.url 为准。'
                              : '旧版模型会按 width、height、num_frames 和 frame_rate 生成，实际输出以 API 返回结果为准。',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: state.isLoading
                                ? null
                                : () => _create(config.videoModel),
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

class _ModernVideoForm extends StatelessWidget {
  const _ModernVideoForm({required this.state, required this.viewModel});

  final VideoState state;
  final VideoGenerationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final mode = const {'text', 'keyframe', 'reference'}.contains(state.mode)
        ? state.mode
        : 'text';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 190,
              child: DropdownButtonFormField<String>(
                initialValue: mode,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: '生成模式',
                  prefixIcon: Icon(Icons.tune_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: 'text', child: Text('text · 文生视频')),
                  DropdownMenuItem(
                    value: 'keyframe',
                    child: Text('keyframe · 首尾帧'),
                  ),
                  DropdownMenuItem(
                    value: 'reference',
                    child: Text('reference · 多模态参考'),
                  ),
                ],
                onChanged: state.isLoading ? null : viewModel.setMode,
              ),
            ),
            SizedBox(
              width: 150,
              child: DropdownButtonFormField<String>(
                initialValue: state.seconds,
                isExpanded: true,
                decoration: const InputDecoration(labelText: '时长'),
                items: [
                  for (final value in ['4', '5', '6', '8', '10', '12'])
                    DropdownMenuItem(value: value, child: Text('$value 秒')),
                ],
                onChanged: state.isLoading
                    ? null
                    : (value) {
                        if (value != null) viewModel.setSeconds(value);
                      },
              ),
            ),
            SizedBox(
              width: 150,
              child: DropdownButtonFormField<String>(
                initialValue: state.size,
                isExpanded: true,
                decoration: const InputDecoration(labelText: '分辨率'),
                items: const [
                  DropdownMenuItem(value: '720P', child: Text('720P')),
                  DropdownMenuItem(value: '1080P', child: Text('1080P')),
                  DropdownMenuItem(value: '1K', child: Text('1K · 方形')),
                  DropdownMenuItem(value: '2K', child: Text('2K')),
                ],
                onChanged: state.isLoading ? null : viewModel.setSize,
              ),
            ),
            SizedBox(
              width: 150,
              child: DropdownButtonFormField<String>(
                initialValue: state.aspectRatio,
                isExpanded: true,
                decoration: const InputDecoration(labelText: '画幅'),
                items: const [
                  DropdownMenuItem(value: '21:9', child: Text('21:9 · 超宽')),
                  DropdownMenuItem(value: '16:9', child: Text('16:9 · 横屏')),
                  DropdownMenuItem(value: '4:3', child: Text('4:3')),
                  DropdownMenuItem(value: '1:1', child: Text('1:1 · 方形')),
                  DropdownMenuItem(value: '3:4', child: Text('3:4')),
                  DropdownMenuItem(value: '9:16', child: Text('9:16 · 竖屏')),
                ],
                onChanged: state.isLoading ? null : viewModel.setAspectRatio,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (mode == 'keyframe')
          _KeyframeFields(state: state, viewModel: viewModel),
        if (mode == 'reference')
          _ReferenceFields(state: state, viewModel: viewModel),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: const Text('高级参数'),
          subtitle: const Text('seed 与提示词中的素材引用说明'),
          childrenPadding: const EdgeInsets.only(bottom: 4),
          children: [
            TextFormField(
              initialValue: state.seed,
              onChanged: viewModel.setSeed,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'seed（可选）',
                hintText: '传入相同种子可提高结果复现性',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'reference 模式请在提示词中使用 <Picture 1>、<Audio 1>、<Video 1> 指代对应素材。',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class _KeyframeFields extends StatelessWidget {
  const _KeyframeFields({required this.state, required this.viewModel});

  final VideoState state;
  final VideoGenerationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: state.firstFrame,
          onChanged: viewModel.setFirstFrame,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'first_frame（可选）',
            hintText: '首帧图片的公开 URL；首帧和尾帧至少填写一个',
            prefixIcon: Icon(Icons.first_page_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: state.lastFrame,
          onChanged: viewModel.setLastFrame,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'last_frame（可选）',
            hintText: '尾帧图片的公开 URL',
            prefixIcon: Icon(Icons.last_page_outlined),
          ),
        ),
      ],
    );
  }
}

class _ReferenceFields extends StatelessWidget {
  const _ReferenceFields({required this.state, required this.viewModel});

  final VideoState state;
  final VideoGenerationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: state.imageUrls,
          onChanged: viewModel.setImageUrls,
          minLines: 2,
          maxLines: 4,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'images（可选，每行一个）',
            hintText: '最多 8 张图片 URL',
            alignLabelWithHint: true,
            prefixIcon: Icon(Icons.image_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: state.audioUrls,
          onChanged: viewModel.setAudioUrls,
          minLines: 2,
          maxLines: 3,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'audios（可选，每行一个）',
            hintText: '最多 3 段音频 URL',
            alignLabelWithHint: true,
            prefixIcon: Icon(Icons.audiotrack_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: state.referenceVideoUrl,
          onChanged: viewModel.setReferenceVideoUrl,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'videos[0].url（可选）',
            hintText: '最多 1 个、时长 2–12 秒的参考视频 URL',
            prefixIcon: Icon(Icons.video_library_outlined),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: TextFormField(
                initialValue: state.referenceVideoStartSeconds,
                onChanged: viewModel.setReferenceVideoStartSeconds,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'start_seconds',
                  suffixText: '秒',
                ),
              ),
            ),
            FilterChip(
              label: const Text('必须包含音轨'),
              selected: state.referenceVideoRequireAudio,
              onSelected: state.isLoading
                  ? null
                  : viewModel.setReferenceVideoRequireAudio,
            ),
          ],
        ),
      ],
    );
  }
}

class _LegacyVideoForm extends StatelessWidget {
  const _LegacyVideoForm({required this.state, required this.viewModel});

  final VideoState state;
  final VideoGenerationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            _NumberField(
              value: state.width,
              label: 'width',
              suffix: 'px',
              onChanged: viewModel.setWidth,
            ),
            _NumberField(
              value: state.height,
              label: 'height',
              suffix: 'px',
              onChanged: viewModel.setHeight,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _NumberField(
              value: state.numFrames,
              label: 'num_frames',
              helper: '≤ 441 且为 8n+1',
              onChanged: viewModel.setNumFrames,
            ),
            _NumberField(
              value: state.frameRate,
              label: 'frame_rate',
              helper: '1–60 fps',
              decimal: true,
              onChanged: viewModel.setFrameRate,
            ),
            SizedBox(
              width: 260,
              child: DropdownButtonFormField<String>(
                initialValue: state.mode,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'mode（可选）'),
                items: const [
                  DropdownMenuItem(value: '', child: Text('默认')),
                  DropdownMenuItem(
                    value: 'ti2vid',
                    child: Text('ti2vid · 图生视频'),
                  ),
                  DropdownMenuItem(
                    value: 'keyframes',
                    child: Text('keyframes · 关键帧'),
                  ),
                ],
                onChanged: state.isLoading ? null : viewModel.setMode,
              ),
            ),
          ],
        ),
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
                hintText: '图生视频使用的公开图片 URL',
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
                labelText: 'extra_body.image（可选，每行一个）',
                hintText: '关键帧图片 URL',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _NumberField(
                  value: state.numInferenceSteps,
                  label: 'num_inference_steps',
                  onChanged: viewModel.setNumInferenceSteps,
                ),
                _NumberField(
                  value: state.seed,
                  label: 'seed',
                  onChanged: viewModel.setSeed,
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.value,
    required this.label,
    required this.onChanged,
    this.suffix,
    this.helper,
    this.decimal = false,
  });

  final String value;
  final String label;
  final String? suffix;
  final String? helper;
  final bool decimal;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          helperText: helper,
        ),
      ),
    );
  }
}
