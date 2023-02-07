// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/infra/adapters/coletas_adapter.dart';
import 'package:agil_coletas/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/tiket_adapter.dart';

class HomeDatasource implements IHomeDatasource {
  final ISQLFliteStorage storage;
  final IClientHttp clientHttp;

  HomeDatasource({
    required this.storage,
    required this.clientHttp,
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

    final filters = FilterEntity(
        name: 'ID',
        value: idCriado,
        type: FilterType.equal,
        operator: FilterOperator.and);

    final params = SQLFliteGetPerFilterParam(
        table: Tables.coletas, columns: [], filters: {filters});

    final result = await storage.getPerFilter(params);

    return result.first;
  }

  @override
  Future<bool> updateColeta(Coletas coleta) async {
    final param = SQLFliteUpdateParam(
      table: Tables.coletas,
      id: coleta.id,
      fieldsWithValues: ColetasAdapter.toMapSQL(coleta),
    );

    final result = await storage.update(param);

    return result;
  }

  @override
  Future<bool> sendColetaToServer() async {
    // Get coletas that match filter criteria
    final coletasResult = await storage.getPerFilter(
        SQLFliteGetPerFilterParam(table: Tables.coletas, columns: [], filters: {
      const FilterEntity(
          name: 'ENVIADA',
          value: 0,
          type: FilterType.equal,
          operator: FilterOperator.and),
      const FilterEntity(
          name: 'FINALIZADA',
          value: 1,
          type: FilterType.equal,
          operator: FilterOperator.and),
    }));

    // Convert result to Coletas objects
    final coletas = coletasResult.map(ColetasAdapter.fromMap).toList();

    // Get coletas with tickets
    final coletasWithTikets = await Future.wait(coletas.map((coleta) async {
      final tiketsResult = await storage.getColetasTikets(coleta.id);
      final listTikets = tiketsResult.map(TiketAdapter.fromMap).toList();
      return {
        ...ColetasAdapter.toMapServer(coleta),
        'tikets': TiketAdapter.toListJsonServer(listTikets)
      };
    }));

    if (coletasWithTikets.isNotEmpty) {
      final response = await postColetasToServer(coletasWithTikets);
      if (response.statusCode != 200) {
        throw MyException(
            message:
                'Erro ao tentar enviar coletas para o servidor ${response.statusCode}');
      }

      // Update ENVIADA field for coletas
      await Future.wait(coletas.map((coleta) async {
        await storage.update(SQLFliteUpdateParam(
            table: Tables.coletas,
            id: coleta.id,
            fieldsWithValues: {'ENVIADA': 1}));
      }));

      return true;
    }

    return false;
  }

  Future<BaseResponse> postColetasToServer(
      List<Map<String, dynamic>> coletas) async {
    return await clientHttp.post(
      '$baseUrl/setJson/$cnpjSemCaracter/coletas/${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}_${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}',
      data: jsonEncode(coletas),
    );
  }

  @override
  Future<bool> removeAll() async {
    final param = SQLFliteDeleteAllParam(table: Tables.coletas);

    await storage.deleteAll(param);

    return true;
  }
}
