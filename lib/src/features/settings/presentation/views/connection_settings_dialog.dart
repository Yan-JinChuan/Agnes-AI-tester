import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/features/settings/domain/models/model_info.dart';
import 'package:agnes_ai_tester/src/features/settings/presentation/viewmodels/model_catalog_view_model.dart';
import 'package:agnes_ai_tester/src/features/settings/presentation/viewmodels/settings_view_model.dart';

import '../../../../core/config/app_config_provider.dart';

/// 编辑应用的连接、模型和本地缓存设置。
class ConnectionSettingsDialog extends ConsumerStatefulWidget {
  const ConnectionSettingsDialog({super.key});

  @override
  ConsumerState<ConnectionSettingsDialog> createState() =>
      _ConnectionSettingsDialogState();
}

String _formatCacheBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) {
    return '${(bytes / 1024).toStringAsFixed(1)} KB';
  }
  if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
}

class _ConnectionSettingsDialogState
    extends ConsumerState<ConnectionSettingsDialog> {
  late final TextEditingController _apiKeyController;
  late final TextEditingController _baseUrlController;
  late final TextEditingController _textModelController;
  late final TextEditingController _imageModelController;
  late final TextEditingController _videoModelController;
  late final TextEditingController _cacheDirectoryController;
  bool _obscureApiKey = true;
  bool _isPickingDirectory = false;
  String? _dialogMessage;

  @override
  void initState() {
    super.initState();
    final config = ref.read(appConfigProvider);
    _apiKeyController = TextEditingController(text: config.apiKey);
    _baseUrlController = TextEditingController(text: config.baseUrl);
    _textModelController = TextEditingController(text: config.textModel);
    _imageModelController = TextEditingController(text: config.imageModel);
    _videoModelController = TextEditingController(text: config.videoModel);
    _cacheDirectoryController = TextEditingController(
      text: config.cacheDirectory,
    );
    // 首帧完成后再修改 Provider，避免 Riverpod 在 widget 挂载期间拒绝状态更新。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(
          ref.read(settingsViewModelProvider.notifier).loadCacheUsage(),
        );
      }
    });
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    _textModelController.dispose();
    _imageModelController.dispose();
    _videoModelController.dispose();
    _cacheDirectoryController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final current = ref.read(appConfigProvider);
    final config = current.copyWith(
      apiKey: _apiKeyController.text,
      baseUrl: _baseUrlController.text,
      textModel: _textModelController.text,
      imageModel: _imageModelController.text,
      videoModel: _videoModelController.text,
      cacheDirectory: _cacheDirectoryController.text,
    );
    final saved = await ref
        .read(settingsViewModelProvider.notifier)
        .saveConfig(config);
    if (mounted && saved) Navigator.of(context).pop();
  }

  Future<void> _pickCacheDirectory() async {
    if (kIsWeb) {
      _showMessage('Web 端受浏览器沙箱限制，无法选择本机缓存目录。');
      return;
    }
    setState(() => _isPickingDirectory = true);
    try {
      final selected = await FilePicker.getDirectoryPath(
        dialogTitle: '选择 Agnes 缓存目录',
        initialDirectory: _cacheDirectoryController.text.trim().isEmpty
            ? null
            : _cacheDirectoryController.text.trim(),
      );
      if (selected != null && selected.trim().isNotEmpty) {
        _cacheDirectoryController.text = selected;
      }
    } catch (error) {
      _showMessage('选择缓存目录失败：$error');
    } finally {
      if (mounted) setState(() => _isPickingDirectory = false);
    }
  }

  Future<void> _loadModels() async {
    final apiKey = _apiKeyController.text.trim();
    final baseUrl = _baseUrlController.text.trim();
    if (apiKey.isEmpty) {
      _showMessage('请先填写 API Key。');
      return;
    }
    if (baseUrl.isEmpty) {
      _showMessage('请先填写 Base URL。');
      return;
    }

    setState(() => _dialogMessage = null);
    ref
        .read(settingsViewModelProvider.notifier)
        .previewConfig(apiKey: apiKey, baseUrl: baseUrl);
    if (!mounted) return;
    await ref.read(modelCatalogViewModelProvider.notifier).load();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    setState(() => _dialogMessage = message);
  }

  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清除缓存'),
        content: const Text('将删除图片和视频缓存，是否继续？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确认清除'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;

    final cleared = await ref
        .read(settingsViewModelProvider.notifier)
        .clearCache();
    if (mounted && cleared) _showMessage('缓存已清除');
  }

  Widget _buildCacheSection(SettingsState state) {
    final usage = state.cacheUsage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                '缓存管理',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            if (state.isLoadingCache || state.isClearingCache)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (usage == null)
          Text(
            state.isLoadingCache ? '正在读取缓存占用…' : '暂无缓存统计',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
          )
        else
          Text(
            '图片缓存：${_formatCacheBytes(usage.imageBytes)}\n'
            '普通视频：${_formatCacheBytes(usage.videoBytes)}\n'
            '总占用：${_formatCacheBytes(usage.totalBytes)}',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12.5),
          ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton.icon(
            onPressed: state.isClearingCache ? null : _clearCache,
            icon: const Icon(Icons.delete_sweep_outlined),
            label: const Text('清除全部缓存'),
          ),
        ),
      ],
    );
  }

  Widget _buildModelField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required List<ModelInfo> models,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon),
            ),
          ),
        ),
        if (models.isNotEmpty) ...[
          const SizedBox(width: 6),
          PopupMenuButton<String>(
            tooltip: '从模型列表选择',
            icon: const Icon(Icons.list_alt_outlined),
            onSelected: (value) => setState(() => controller.text = value),
            itemBuilder: (context) => [
              for (final model in models)
                PopupMenuItem<String>(
                  value: model.id,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Text(
                      model.displayName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsViewModelProvider);
    return AlertDialog(
      title: const Text('连接设置'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _apiKeyController,
                obscureText: _obscureApiKey,
                decoration: InputDecoration(
                  labelText: 'API Key',
                  prefixIcon: const Icon(Icons.key_outlined),
                  suffixIcon: IconButton(
                    tooltip: _obscureApiKey ? '显示 API Key' : '隐藏 API Key',
                    onPressed: () =>
                        setState(() => _obscureApiKey = !_obscureApiKey),
                    icon: Icon(
                      _obscureApiKey
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _baseUrlController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Base URL',
                  prefixIcon: Icon(Icons.link_outlined),
                ),
              ),
              if (_dialogMessage != null || settingsState.error != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            _dialogMessage ?? settingsState.error!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: '关闭提示',
                        visualDensity: VisualDensity.compact,
                        onPressed: () => setState(() => _dialogMessage = null),
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (!kIsWeb) ...[
                const SizedBox(height: 14),
                TextField(
                  controller: _cacheDirectoryController,
                  decoration: InputDecoration(
                    labelText: '缓存目录（可选）',
                    hintText: r'C:\AgnesCache',
                    helperText: '选择绝对路径；留空使用应用默认缓存目录。',
                    prefixIcon: const Icon(Icons.folder_outlined),
                    suffixIcon: _isPickingDirectory
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_cacheDirectoryController.text.isNotEmpty)
                                IconButton(
                                  tooltip: '使用默认缓存目录',
                                  onPressed: () =>
                                      setState(_cacheDirectoryController.clear),
                                  icon: const Icon(Icons.clear),
                                ),
                              IconButton(
                                tooltip: '选择缓存目录',
                                onPressed: _pickCacheDirectory,
                                icon: const Icon(Icons.folder_open_outlined),
                              ),
                            ],
                          ),
                  ),
                  readOnly: true,
                  onTap: _pickCacheDirectory,
                ),
              ],
              if (!kIsWeb) ...[
                const SizedBox(height: 14),
                _buildCacheSection(settingsState),
              ],
              const SizedBox(height: 14),
              Builder(
                builder: (context) {
                  final modelState = ref.watch(modelCatalogViewModelProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              '模型配置',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (modelState.models.isNotEmpty &&
                              !modelState.isLoading)
                            Text(
                              '${modelState.models.length} 个可用模型',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: modelState.isLoading
                                ? null
                                : _loadModels,
                            icon: modelState.isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.cloud_sync_outlined),
                            label: Text(
                              modelState.isLoading ? '获取中…' : '获取模型列表',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '可手动输入模型名；获取列表后，点击字段右侧按钮即可选择。',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      if (modelState.error != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          modelState.error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      _buildModelField(
                        label: '文本模型',
                        icon: Icons.chat_outlined,
                        controller: _textModelController,
                        models: modelState.models,
                      ),
                      const SizedBox(height: 14),
                      _buildModelField(
                        label: '图片模型',
                        icon: Icons.image_outlined,
                        controller: _imageModelController,
                        models: modelState.models,
                      ),
                      const SizedBox(height: 14),
                      _buildModelField(
                        label: '视频模型',
                        icon: Icons.movie_outlined,
                        controller: _videoModelController,
                        models: modelState.models,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                '配置会写入本地 SQLite，API Key 请仅用于本机测试。',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: settingsState.isSaving ? null : _save,
          child: settingsState.isSaving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('保存设置'),
        ),
      ],
    );
  }
}
