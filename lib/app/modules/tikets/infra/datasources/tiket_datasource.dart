import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';

abstract class ITiketDatasource {
  Future<bool> createTikets(List<Produtor> produtores);
  Future<List> getTikets(int idColeta);

  //Produtores
  Future<String> getProdutoresOnline();
  Future<List> getProdutoresOffline(int codRota);
  Future<bool> saveProdutores(List<Produtor> produtores);
}
