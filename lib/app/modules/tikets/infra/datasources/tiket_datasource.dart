import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';

abstract class ITiketDatasource {
  Future<int> createTikets(List<Produtor> produtores, Coletas coleta);
  Future<List> getTikets(int idColeta);

  //Produtores
  Future<String> getProdutoresOnline();
  Future<List> getProdutoresOffline(int codRota);
  Future<bool> saveProdutores(List<Produtor> produtores);
}
