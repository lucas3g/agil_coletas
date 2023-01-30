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
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
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
    const filterColetas = FilterEntity(
        name: 'ENVIADA',
        value: 0,
        type: FilterType.equal,
        operator: FilterOperator.and);

    const filterFinalizada = FilterEntity(
        name: 'FINALIZADA',
        value: 1,
        type: FilterType.equal,
        operator: FilterOperator.and);

    final paramGetColetas = SQLFliteGetPerFilterParam(
        table: Tables.coletas,
        columns: [],
        filters: {filterColetas, filterFinalizada});

    final result = await storage.getPerFilter(paramGetColetas);

    final List<Coletas> coletas = [];

    for (var coleta in result) {
      coletas.add(ColetasAdapter.fromMap(coleta));
    }

    List<Map<String, dynamic>> coletasWithTikets = [];

    if (coletas.isNotEmpty) {
      for (var coleta in coletas) {
        final tikets = await storage.getColetasTikets(coleta.id);

        final List<Tiket> listTikets = [];

        for (var tiket in tikets) {
          listTikets.add(TiketAdapter.fromMap(tiket));
        }

        if (tikets.isNotEmpty) {
          coletasWithTikets = [
            {
              ...ColetasAdapter.toMapServer(coleta),
              'tikets': TiketAdapter.toListJsonServer(listTikets)
            },
            ...coletasWithTikets
          ];
        }
      }
    } else {
      return false;
    }

    final response = await clientHttp.post(
      '$baseUrl/setJson/$cnpjSemCaracter/coletas/${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}_${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}',
      data: jsonEncode(coletasWithTikets),
    );

    if (response.statusCode != 200) {
      throw MyException(
          message:
              'Erro ao tentar enviar coletas para o servidor ${response.statusCode}');
    }

    for (var coleta in coletas) {
      final paramUpdate = SQLFliteUpdateParam(
        table: Tables.coletas,
        id: coleta.id,
        fieldsWithValues: {'ENVIADA': 1},
      );

      await storage.update(paramUpdate);
    }

    return true;
  }

  @override
  Future<bool> removeAll() async {
    final param = SQLFliteDeleteAllParam(table: Tables.coletas);

    await storage.deleteAll(param);

    return true;
  }
}
