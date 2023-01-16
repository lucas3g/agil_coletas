abstract class IRotasDatasource {
  Future<String> getRotasOnline();
  Future<List> getRotasOffline();
  Future<List> getRotasNaoFinalizadas();
}
