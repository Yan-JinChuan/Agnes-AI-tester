import 'package:agnes_ai_tester/src/core/config/app_config.dart';
import 'package:agnes_ai_tester/src/core/config/app_config_provider.dart';
import 'package:agnes_ai_tester/src/core/storage/app_config_dao.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/storage/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final dao = AppConfigDao(await db.database);
  final initialConfig = await dao.readConfig() ?? const AppConfig();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        appConfigProvider.overrideWithValue(initialConfig),
      ],
      child: const AgnesApp(),
    ),
  );
}
