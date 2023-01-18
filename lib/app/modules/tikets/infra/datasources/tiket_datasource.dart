abstract class ITiketDatasource {
  Future<int> createTikets(int codRota);
  Future<List> getTikets(int idColeta);
}
