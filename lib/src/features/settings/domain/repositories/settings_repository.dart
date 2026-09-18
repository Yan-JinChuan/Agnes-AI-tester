import '../models/model_info.dart';

abstract interface class SettingsRepository {
  Future<List<ModelInfo>> fetchModels();
}
