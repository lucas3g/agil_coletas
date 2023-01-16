abstract class IRotasDatasource {
  Future<String> getRotasOnline();
  Future<List> getRotasOffline();
}
