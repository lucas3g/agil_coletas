import 'dart:async';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
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
  Future<int> create(SQLFliteInsertParam param) async {
    late int id = 0;

    await _db!.transaction((txn) async {
      id = await txn.insert(param.table.name.toUpperCase(), param.data);
    });

    return id;
  }

  @override
  Future<int> rawCreate(SQLFliteRawInsertParam param) async {
    late int id = 0;

    await _db!.transaction((txn) async {
      id = await txn.rawInsert(param.sql);
    });

    return id;
  }

  @override
  Future<void> delete(SQLFliteDeleteParam param) async {
    await _db!.transaction((txn) async {
      await txn.delete(
        param.table.name.toUpperCase(),
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
        param.table.name.toUpperCase(),
      );
    });

    return List<Map<String, dynamic>>.from(result);
  }

  @override
  Future<List<Map<String, dynamic>>> getPerFilter(
      SQLFliteGetPerFilterParam param) async {
    late List<Map<String, dynamic>> result;

    late String? where =
        param.filters?.map(SqFliteHelpers.convertFilterToSqlWhere).toString();

    if (param.filters?.map((e) => e).length == 1) {
      where = where?.replaceAll('and', '');
    } else {
      where = '${where?.substring(0, where.length - 4).replaceAll(',', '')})';
    }

    if (where == 'null)') {
      where = null;
    }

    await _db!.transaction((txn) async {
      result = await txn.query(
        param.table.name.toUpperCase(),
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
      onCreate: (Database db, int version) async {
        return await SqFliteHelpers.onCreate(_tables, db, version);
      },
    );
  }

  @override
  Future<bool> update(SQLFliteUpdateParam param) async {
    late int atualizou;

    await _db!.transaction((txn) async {
      atualizou = await txn.update(
        param.table.name.toUpperCase(),
        param.fieldsWithValues,
        where: 'id = ?',
        whereArgs: [param.id],
      );
    });

    return atualizou > 0;
  }

  @override
  Future<bool> rawUpdate(SQLFliteRawUpdateParam param) async {
    late int atualizou;

    await _db!.transaction((txn) async {
      atualizou = await txn.rawUpdate(param.sql, param.values);
    });

    return atualizou > 0;
  }

  @override
  Future<void> deleteAll(SQLFliteDeleteAllParam param) async {
    await _db!.transaction((txn) async {
      await txn.delete(
        param.table.name.toUpperCase(),
      );
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getColetasTikets(int idColeta) async {
    List<Map<String, dynamic>> result = [];

    await _db!.transaction((txn) async {
      result = await txn.query(
        Tables.tikets.name.toUpperCase(),
        where:
            'id_coleta = ? and (quantidade > 0 or temperatura != 0 or observacao != ?) ',
        whereArgs: [idColeta, ''],
      );
    });

    return List<Map<String, dynamic>>.from(result);
  }
}
