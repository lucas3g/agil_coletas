import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/adapters/produtor_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
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
  Future<int> createTikets(Coletas coleta) async {
    final filter = FilterEntity(
        name: 'ROTA',
        value: coleta.rota.codigo,
        type: FilterType.equal,
        operator: FilterOperator.and);

    final paramGet = SQLFliteGetPerFilterParam(
        table: Tables.produtores, columns: [], filters: {filter});

    final result = await storage.getPerFilter(paramGet);

    late List<Produtor> produtores = [];

    for (var produtor in result) {
      produtores.add(ProdutorAdapter.fromMap(produtor));
    }

    for (var produtor in produtores) {
      final param = SQLFliteInsertParam(
        table: Tables.tikets,
        data: TiketAdapter.toMapSQLFlite(produtor, coleta),
      );

      await storage.create(param);
    }

    return coleta.id;
  }

  @override
  Future<List> getTikets(int idColeta) async {
    final filters = FilterEntity(
        name: 'ID_COLETA',
        value: idColeta,
        type: FilterType.equal,
        operator: FilterOperator.and);

    final param = SQLFliteGetPerFilterParam(
        table: Tables.tikets, columns: [], filters: {filters});

    final result = await storage.getPerFilter(param);

    return result;
  }

  @override
  Future<bool> updateTiket(Tiket tiket) async {
    final param = SQLFliteUpdateParam(
      table: Tables.tikets,
      id: tiket.id.value,
      fieldsWithValues: TiketAdapter.toMapUpdate(tiket),
    );

    final result = await storage.update(param);

    return result;
  }
}
