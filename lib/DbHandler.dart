import 'dart:convert';

import 'package:flutter_form/DataModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler {
  static const String tblName = "FormData";
  static Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE "FormData" ( "id" INTEGER, "formValue" TEXT,PRIMARY KEY("id" AUTOINCREMENT))');
    });
    return database;
  }

  static Future<DataModel> insertFormData(DataModel dataModel) async {
    Database database = await getDatabase();
    dataModel.id = await database.insert(tblName, dataModel.toJson());
    return dataModel;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> list =
        await database.rawQuery("Select * from $tblName");
    return list;
  }

  static Future<DataModel> updateData(int id, DataModel dataModel) async {
    Database database = await getDatabase();
    dataModel.id = await database
        .update(tblName, dataModel.toJson(), where: "id=?", whereArgs: [id]);

    return dataModel;
  }
}
