import 'package:flutter_test/flutter_test.dart';

import 'package:agnes_ai_tester/src/core/storage/app_database.dart';

void main() {
  test('opens one database instance with the complete schema', () async {
    final database = await AppDatabase.open(databasePath: ':memory:');
    addTearDown(database.close);

    expect(database.database.isOpen, isTrue);

    final rows = await database.database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table'",
    );
    final tableNames = rows
        .map((row) => row['name'])
        .whereType<String>()
        .toSet();

    expect(
      tableNames,
      containsAll(<String>[
        DataBaseTableNames.settings,
        DataBaseTableNames.conversations,
        DataBaseTableNames.messages,
        DataBaseTableNames.imageGenerations,
        DataBaseTableNames.videoGenerations,
      ]),
    );
  });
}
