// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/produtor_adapter.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/tiket_adapter.dart';
import 'package:agil_coletas/app/modules/tikets/infra/datasources/tiket_datasource.dart';

class TiketDatasource implements ITiketDatasource {
  final IClientHttp clientHttp;
  final ISQLFliteStorage storage;

  TiketDatasource({
    required this.clientHttp,
    required this.storage,
  });

  @override
  Future<bool> createTikets(List<Produtor> produtores) async {
    for (var produtor in produtores) {
      final param = SQLFliteInsertParam(
          table: Tables.produtores, data: TiketAdapter.toMapSQLFlite(produtor));

      await storage.create(param);
    }

    return true;
  }

  @override
  Future<String> getProdutoresOnline() async {
    final result = await clientHttp
        .get('$baseUrl/getJson/$cnpjSemCaracter/rotas/clientes');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar produtores do servidor');
    }

    return result.data;
  }

  @override
  Future<List> getTikets(int idColeta) async {
    final filters = FilterEntity(
        name: 'ID_COLETA', value: idColeta, type: FilterType.equal);

    final param = SQLFliteGetPerFilterParam(
        table: Tables.produtores, columns: [], filters: {filters});

    final result = await storage.getPerFilter(param);

    return result;
  }

  @override
  Future<List> getProdutoresOffline(int codRota) async {
    final filters =
        FilterEntity(name: 'ROTA', value: codRota, type: FilterType.equal);

    final param = SQLFliteGetPerFilterParam(
        table: Tables.produtores, columns: [], filters: {filters});

    final result = await storage.getPerFilter(param);

    return result;
  }

  @override
  Future<bool> saveProdutores(List<Produtor> produtores) async {
    for (var produtor in produtores) {
      final paramDelete = SQLFliteDeleteAllParam(table: Tables.produtores);

      await storage.deleteAll(paramDelete);

      final param = SQLFliteInsertParam(
          table: Tables.produtores, data: ProdutorAdapter.toMap(produtor));

      await storage.create(param);
    }

    return true;
  }
}
