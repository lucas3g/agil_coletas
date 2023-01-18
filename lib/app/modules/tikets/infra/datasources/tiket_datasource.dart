import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';

abstract class ITiketDatasource {
  Future<int> createTikets(List<Produtor> produtores, Coletas coleta);
  Future<List> getTikets(int idColeta);
}
