// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/modules/home/infra/datasources/home_datasource.dart';

class HomeDatasource implements IHomeDatasource {
  final ISQLFliteStorage storage;

  HomeDatasource({
    required this.storage,
  });

  @override
  Future<List> getColetas() async {
    final param = SQLFliteGetAllParam(table: Tables.coletas);

    final result = await storage.getAll(param);

    return result;
  }
}
