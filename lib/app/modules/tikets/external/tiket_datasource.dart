// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/adapters/produtor_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
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
  Future<int> createTikets(int codRota) async {
    final filter =
        FilterEntity(name: 'ROTA', value: codRota, type: FilterType.equal);

    final param = SQLFliteGetPerFilterParam(
        table: Tables.produtores, columns: [], filters: {filter});

    final result = await storage.getPerFilter(param);

    late List<Produtor> produtores = [];

    for (var produtor in result) {
      produtores.add(ProdutorAdapter.fromMap(produtor));
    }

    for (var produtor in produtores) {
      final param = SQLFliteInsertParam(
        table: Tables.produtores,
        data: TiketAdapter.toMapSQLFlite(produtor, codRota),
      );

      await storage.create(param);
    }

    return codRota;
  }

  @override
  Future<List> getTikets(int idColeta) async {
    final filters = FilterEntity(
        name: 'ID_COLETA', value: idColeta, type: FilterType.equal);

    final param = SQLFliteGetPerFilterParam(
        table: Tables.tikets, columns: [], filters: {filters});

    final result = await storage.getPerFilter(param);

    return result;
  }
}
