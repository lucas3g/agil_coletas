// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/adapters/produtor_adapter.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';

class ProdutorDatasource implements IProdutorDatasource {
  final IClientHttp clientHttp;
  final ISQLFliteStorage storage;

  ProdutorDatasource({
    required this.clientHttp,
    required this.storage,
  });

  @override
  Future<String> getProdutores() async {
    final result = await clientHttp
        .get('$baseUrl/getJson/$cnpjSemCaracter/rotas/clientes');

    if (result.statusCode != 200) {
      throw const MyException(message: 'Erro ao buscar produtores do servidor');
    }

    return result.data;
  }

  @override
  Future<bool> saveProdutores(List<Produtor> produtores) async {
    final paramDelete = SQLFliteDeleteAllParam(table: Tables.produtores);

    await storage.deleteAll(paramDelete);

    for (var produtor in produtores) {
      final param = SQLFliteInsertParam(
          table: Tables.produtores, data: ProdutorAdapter.toMap(produtor));

      await storage.create(param);
    }

    return true;
  }
}
