// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/rotas/infra/adapters/rotas_adapter.dart';
import 'package:agil_coletas/app/modules/rotas/infra/datasources/rotas_datasource.dart';

class RotasDatasource implements IRotasDatasource {
  final IClientHttp clientHttp;
  final ISQLFliteStorage storage;

  RotasDatasource({
    required this.clientHttp,
    required this.storage,
  });

  @override
  Future<List> getRotasOffline() async {
    final param = SQLFliteGetAllParam(table: Tables.rotas);

    final result = await storage.getAll(param);

    return result;
  }

  @override
  Future<String> getRotasOnline() async {
    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpjSemCaracter/rotas/rotas');

    if (result.statusCode != 200) {
      throw const MyException(
        message: 'Erro ao tentar buscar rotas do servidor',
      );
    }

    return result.data;
  }

  @override
  Future<List> getRotasNaoFinalizadas() async {
    const filters = FilterEntity(
      name: 'FINALIZADA',
      value: 0, //NÃO
      type: FilterType.equal,
      operator: FilterOperator.and,
    );

    final param = SQLFliteGetPerFilterParam(
      table: Tables.coletas,
      filters: {filters},
      columns: [],
    );

    final result = await storage.getPerFilter(param);

    return result;
  }

  @override
  Future<bool> saveRotas(List<Rotas> rotas) async {
    final paramDelete = SQLFliteDeleteAllParam(table: Tables.rotas);

    await storage.deleteAll(paramDelete);

    for (var rota in rotas) {
      final param = SQLFliteInsertParam(
        table: Tables.rotas,
        data: RotasAdapter.toMapSQL(rota),
      );

      await storage.create(param);
    }

    return true;
  }
}
