import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:agnes_ai_tester/src/core/cache/app_media_cache.dart';

import '../../domain/models/image_generation_record.dart';

class ImageResultCard extends StatelessWidget {
  const ImageResultCard({required this.record, required this.cache, super.key});

  final ImageGenerationRecord record;
  final AppMediaCache cache;

  @override
  Widget build(BuildContext context) {
    final result = record.result;
    final image = result.bytes != null
        ? Image.memory(result.bytes!, fit: BoxFit.contain)
        : result.url != null
        ? CachedImage(url: result.url!, cache: cache, fit: BoxFit.contain)
        : const Center(child: Text('图片结果为空。'));
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    '生成结果',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  '${record.size} · ${_formatImageDate(record.createdAt)}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(record.prompt, style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 260, maxHeight: 680),
              color: const Color(0xFFF0F0F5),
              child: image,
            ),
            if (result.url != null) ...[
              const SizedBox(height: 12),
              SelectableText(
                result.url!,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ImageHistoryList extends StatelessWidget {
  const ImageHistoryList({
    required this.history,
    required this.cache,
    required this.onSelect,
    super.key,
  });

  final List<ImageGenerationRecord> history;
  final AppMediaCache cache;
  final ValueChanged<ImageGenerationRecord> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '图片历史',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final record = history[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onSelect(record),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ImageThumbnail(record: record, cache: cache),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.prompt,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${record.model} · ${record.size} · ${_formatImageDate(record.createdAt)}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({required this.record, required this.cache, super.key});

  final ImageGenerationRecord record;
  final AppMediaCache cache;

  @override
  Widget build(BuildContext context) {
    final result = record.result;
    final child = result.bytes != null
        ? Image.memory(result.bytes!, fit: BoxFit.cover)
        : result.url != null
        ? CachedImage(
            url: result.url!,
            cache: cache,
            fit: BoxFit.cover,
            error: const Icon(Icons.broken_image_outlined),
          )
        : const Icon(Icons.image_not_supported_outlined);
    return SizedBox(width: 76, height: 76, child: Center(child: child));
  }
}

class CachedImage extends StatefulWidget {
  const CachedImage({
    required this.url,
    required this.cache,
    required this.fit,
    this.error,
    super.key,
  });

  final String url;
  final AppMediaCache cache;
  final BoxFit fit;
  final Widget? error;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late Future<Uint8List> _bytes;

  @override
  void initState() {
    super.initState();
    _bytes = widget.cache.getImageBytes(widget.url);
  }

  @override
  void didUpdateWidget(covariant CachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url || oldWidget.cache != widget.cache) {
      _bytes = widget.cache.getImageBytes(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _bytes,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.error ?? const Center(child: Text('图片加载失败。'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Image.memory(snapshot.data!, fit: widget.fit);
      },
    );
  }
}

String _formatImageDate(DateTime value) {
  final local = value.toLocal();
  final date =
      '${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  final time =
      '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  return '$date $time';
}
