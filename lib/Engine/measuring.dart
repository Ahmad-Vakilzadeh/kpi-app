import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfL {
  SqfL._();

  static Future<String> databasePath() async {
    final dbDir = await getDatabasesPath();
    return join(dbDir, 'app.db');
  }

  static Future<void> oneTime() async {
    var dbPath = await databasePath();
    var f = File(dbPath);
    if (f.existsSync()) {
      return;
    }
    final data = await rootBundle.load('assets/database/poly.db');
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(await databasePath()).writeAsBytes(bytes);
  }

  static Future<Database> open() async {
    return await openDatabase(await databasePath());
  }
}
