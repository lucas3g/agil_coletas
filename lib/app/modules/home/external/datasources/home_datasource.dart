// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/infra/adapters/coletas_adapter.dart';
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

  @override
  Future<Map<String, dynamic>> createColeta(Coletas coleta) async {
    final param = SQLFliteInsertParam(
        table: Tables.coletas, data: ColetasAdapter.toMap(coleta));

    final idCriado = await storage.create(param);

    final filters =
        FilterEntity(name: 'ID', value: idCriado, type: FilterType.equal);

    final params = SQLFliteGetPerFilterParam(
        table: Tables.coletas, columns: [], filters: {filters});

    final result = await storage.getPerFilter(params);

    return result.first;
  }
}
