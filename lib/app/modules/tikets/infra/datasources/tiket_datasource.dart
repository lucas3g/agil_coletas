import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';

abstract class ITiketDatasource {
  Future<int> createTikets(Coletas coleta);
  Future<List> getTikets(int idColeta);
  Future<bool> updateTiket(Tiket tiket);
  Future<bool> removeAll();
}
