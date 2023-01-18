import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';

abstract class ITiketDatasource {
  Future<int> createTikets(Coletas coleta);
  Future<List> getTikets(int idColeta);
}
