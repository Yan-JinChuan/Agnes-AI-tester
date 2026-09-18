import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

DatabaseFactory createDatabaseFactory() {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    return databaseFactoryFfi;
  }
  return databaseFactory;
}
