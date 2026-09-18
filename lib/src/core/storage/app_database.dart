import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import 'database_factory.dart';

part 'app_database.g.dart';

abstract class DataBaseTableNames {
  static const String settings = "settings";
  static const String messages = "messages";
  static const String conversations = "conversations";
  static const String idxMessagesConversation = "idx_messages_conversation";
  static const String imageGenerations = "image_generations";
  static const String videoGenerations = "video_generations";
  static const String idxVideoGenerationsUpdated =
      "idx_video_generations_updated";
}

@riverpod
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}

class AppDatabase {
  Database? _database;

  Future<Database> get database async {
    final current = _database;
    if (current != null && current.isOpen) return current;

    final databasePath = await _databasePath();
    _database = await getDatabaseFactory().openDatabase(
      databasePath,
      options: OpenDatabaseOptions(
        version: 3,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: (db, version) async {
          await _createCoreTables(db);
          await _createGenerationTables(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await _createGenerationTables(db);
          } else if (oldVersion < 3) {
            await _upgradeVideoGenerationToV3(db);
          }
        },
      ),
    );
    return _database!;
  }

  Future<String> _databasePath() async {
    if (kIsWeb) return 'agnes_ai_tester.db';
    final directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, 'agnes_ai_tester.db');
  }

  Future<void> close() async {
    final current = _database;
    _database = null;
    if (current != null && current.isOpen) await current.close();
  }

  Future<void> _createCoreTables(Database db) async {
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.conversations} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.messages} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        conversation_id INTEGER NOT NULL,
        role TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (conversation_id) REFERENCES ${DataBaseTableNames.conversations} (id)
          ON DELETE CASCADE
      )
    ''');
    await db.execute(
      'CREATE INDEX ${DataBaseTableNames.idxMessagesConversation} '
      'ON ${DataBaseTableNames.messages} (conversation_id, created_at)',
    );
  }

  Future<void> _createGenerationTables(Database db) async {
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.settings} (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.imageGenerations} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        prompt TEXT NOT NULL,
        model TEXT NOT NULL,
        size TEXT NOT NULL,
        url TEXT,
        image_bytes BLOB,
        created_at INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.videoGenerations} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        video_id TEXT NOT NULL UNIQUE,
        prompt TEXT NOT NULL,
        model TEXT NOT NULL,
        status TEXT NOT NULL,
        progress INTEGER NOT NULL DEFAULT 0,
        url TEXT,
        error TEXT,
        request_json TEXT NOT NULL DEFAULT '{}',
        actual_size TEXT,
        seconds REAL,
        metadata_message TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    await db.execute(
      'CREATE INDEX ${DataBaseTableNames.idxVideoGenerationsUpdated} '
      'ON ${DataBaseTableNames.videoGenerations} (updated_at DESC)',
    );
  }

  Future<void> _upgradeVideoGenerationToV3(Database db) async {
    await db.execute(
      "ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN request_json TEXT NOT NULL DEFAULT '{}'",
    );
    await db.execute(
      'ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN actual_size TEXT',
    );
    await db.execute(
      'ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN seconds REAL',
    );
    await db.execute(
      'ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN metadata_message TEXT',
    );
  }
}
