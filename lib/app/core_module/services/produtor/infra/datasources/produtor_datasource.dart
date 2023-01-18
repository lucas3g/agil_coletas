import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';

abstract class IProdutorDatasource {
  Future<String> getProdutores();
  Future<bool> saveProdutores(List<Produtor> produtores);
}
