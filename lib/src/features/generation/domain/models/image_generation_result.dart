import 'dart:typed_data';

class ImageGenerationResult {
  const ImageGenerationResult({this.url, this.bytes});

  final String? url;
  final Uint8List? bytes;

  bool get isEmpty => url == null && bytes == null;
}
