// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/table_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';

class SQLFliteInsertParam {
  final Tables table;
  final Map<String, dynamic> data;

  SQLFliteInsertParam({
    required this.table,
    required this.data,
  });
}

class SQLFliteRawInsertParam {
  final String sql;

  SQLFliteRawInsertParam({
    required this.sql,
  });
}

class SQLFliteInitParam {
  final String fileName;
  final Set<TableEntity> tables;

  SQLFliteInitParam({
    required this.fileName,
    required this.tables,
  });
}

class SQLFliteDeleteParam {
  final Tables table;
  final int id;

  SQLFliteDeleteParam({
    required this.table,
    required this.id,
  });
}

class SQLFliteDeleteAllParam {
  final Tables table;

  SQLFliteDeleteAllParam({
    required this.table,
  });
}

class SQLFliteUpdateParam {
  final Tables table;
  final int id;
  final Map<String, dynamic> fieldsWithValues;

  SQLFliteUpdateParam({
    required this.table,
    required this.id,
    required this.fieldsWithValues,
  });
}

class SQLFliteRawUpdateParam {
  final String sql;
  final List values;

  SQLFliteRawUpdateParam({
    required this.sql,
    required this.values,
  });
}

class SQLFliteGetAllParam {
  final Tables table;

  SQLFliteGetAllParam({
    required this.table,
  });
}

class SQLFliteGetPerFilterParam {
  final Tables table;
  final Set<FilterEntity>? filters;
  final bool orderByID;
  final List<String> columns;
  final int limit;

  SQLFliteGetPerFilterParam({
    required this.table,
    this.filters,
    this.orderByID = false,
    required this.columns,
    this.limit = 0,
  });
}
