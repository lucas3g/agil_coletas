import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/modules/transportador/infra/adapters/transportador_adapter.dart';
import 'package:agil_coletas/app/modules/transportador/infra/datasources/transportador_datasouce.dart';
import 'package:brasil_fields/brasil_fields.dart';

class TransportadorDatasource implements ITransportadorDatasource {
  final IClientHttp clientHttp;
  final ISQLFliteStorage storage;

  TransportadorDatasource({required this.clientHttp, required this.storage});

  @override
  Future<List> getTransportadorOffline() async {
    final param = SQLFliteGetAllParam(table: Tables.caminhoes);

    final result = await storage.getAll(param);

    return result;
  }

  @override
  Future<String> getTransportadorOnline() async {
    final cnpj = UtilBrasilFields.removeCaracteres(
            GlobalFuncionario.instance.funcionario.empresa.cnpj)
        .substring(0, 8);

    final result = await clientHttp.get('$baseUrl/getJson/$cnpj/transp/transp');

    if (result.statusCode != 200) {
      throw const MyException(
        message: 'Erro ao tentar buscar transportadores do servidor',
      );
    }

    return result.data;
  }

  @override
  Future<String> getUltimoTransportador() async {
    final param = SQLFliteGetPerFilterParam(
      table: Tables.coletas,
      orderByID: true,
      columns: ['PLACA'],
      limit: 1,
    );

    final result = await storage.getPerFilter(param);

    return result.isNotEmpty ? result[0]['PLACA'] : '';
  }

  @override
  Future<bool> saveTransportadores(List<Transportador> transportadores) async {
    final paramDelete = SQLFliteDeleteAllParam(table: Tables.caminhoes);

    await storage.deleteAll(paramDelete);

    for (var transp in transportadores) {
      final param = SQLFliteInsertParam(
        table: Tables.caminhoes,
        data: TransportadorAdapter.toMapSQL(transp),
      );

      await storage.create(param);
    }

    return true;
  }
}
