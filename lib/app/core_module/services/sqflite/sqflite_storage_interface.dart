import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';

abstract class ISQLFliteStorage {
  Future<void> init(SQLFliteInitParam param);
  Future<int> create(SQLFliteInsertParam params);
  Future<int> rawCreate(SQLFliteRawInsertParam params);
  Future<List<Map<String, dynamic>>> getPerFilter(
      SQLFliteGetPerFilterParam param);
  Future<List<Map<String, dynamic>>> getAll(SQLFliteGetAllParam param);
  Future<void> delete(SQLFliteDeleteParam param);
  Future<void> deleteAll(SQLFliteDeleteAllParam param);
  Future<bool> update(SQLFliteUpdateParam param);
  Future<bool> rawUpdate(SQLFliteRawUpdateParam param);
}
