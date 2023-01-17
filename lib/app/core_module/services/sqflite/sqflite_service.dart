import 'dart:async';
import 'package:path/path.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/table_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/helpers/sqlflite_helper.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';

import 'package:sqflite/sqflite.dart';

class SQLFliteService implements ISQLFliteStorage {
  late Set<TableEntity> _tables;
  static Database? _db;

  SQLFliteService();

  @override
  Future<bool> create(SQLFliteInsertParam param) async {
    late int gravou = 0;

    await _db!.transaction((txn) async {
      gravou = await txn.insert(param.table.name, param.data);
    });

    return gravou > 0;
  }

  @override
  Future<void> delete(SQLFliteDeleteParam param) async {
    await _db!.transaction((txn) async {
      await txn.delete(
        param.table.name,
        where: 'id = ?',
        whereArgs: [param.id],
      );
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(SQLFliteGetAllParam param) async {
    List<Map<String, dynamic>> result = [];

    await _db!.transaction((txn) async {
      result = await txn.query(
        param.table.name,
      );
    });

    return List<Map<String, dynamic>>.from(result);
  }

  @override
  Future<List<Map<String, dynamic>>> getPerFilter(
      SQLFliteGetPerFilterParam param) async {
    late List<Map<String, dynamic>> result;

    final where = param.filters
        ?.map(SqFliteHelpers.convertFilterToSqlWhere)
        .join(' and ');

    await _db!.transaction((txn) async {
      result = await txn.query(
        param.table.name,
        where: where,
        whereArgs: param.filters
            ?.map(SqFliteHelpers.convertFilterToSqlWhereArgs)
            .toList(),
        orderBy: param.orderByID ? 'id desc' : null,
        columns: param.columns.isNotEmpty
            ? param.columns.map((e) => e).toList()
            : null,
        limit: param.limit > 0 ? param.limit : null,
      );
    });

    return List<Map<String, dynamic>>.from(result);
  }

  @override
  Future<void> init(SQLFliteInitParam param) async {
    _tables = param.tables;

    String databasePath = await getDatabasesPath();
    String path = join(databasePath, param.fileName);

    _db ??= await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        return SqFliteHelpers.onCreate(_tables, db, version);
      },
    );
  }

  @override
  Future<void> update(SQLFliteUpdateParam param) async {
    await _db!.transaction((txn) async {
      await txn.update(
        param.table.name,
        {param.field: param.value},
        where: 'id = ?',
        whereArgs: [param.id],
      );
    });
  }

  @override
  Future<void> deleteAll(SQLFliteDeleteAllParam param) async {
    await _db!.transaction((txn) async {
      await txn.delete(
        param.table.name,
      );
    });
  }
}
