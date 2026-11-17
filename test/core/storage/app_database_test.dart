import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';

import 'package:agnes_ai_tester/src/core/storage/app_database.dart';

void main() {
  test('opens one database instance with the complete schema', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final rows = await database
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .get();
    final tableNames = rows.map((row) => row.read<String>('name')).toSet();

    expect(
      tableNames,
      containsAll(<String>[
        'settings',
        'conversations',
        'messages',
        'image_generations',
        'video_generations',
      ]),
    );
  });

  test(
    'synchronous database provider reuses the initialized instance',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      final container = ProviderContainer(
        overrides: [
          appDatabaseInitializationProvider.overrideWith(
            (ref) async => database,
          ),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(database.close);

      final initialized = await container.read(
        appDatabaseInitializationProvider.future,
      );
      final synchronous = container.read(appDatabaseProvider);

      expect(identical(initialized, synchronous), isTrue);
    },
  );
}
