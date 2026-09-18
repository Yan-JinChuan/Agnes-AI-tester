class ModelInfo {
  const ModelInfo({required this.id, this.ownedBy});

  final String id;
  final String? ownedBy;

  String get displayName =>
      ownedBy == null || ownedBy!.isEmpty ? id : '$id · $ownedBy';
}
