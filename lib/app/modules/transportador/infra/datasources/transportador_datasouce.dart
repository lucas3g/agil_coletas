abstract class ITransportadorDatasource {
  Future<String> getTransportadorOnline();
  Future<List> getTransportadorOffline();
  Future<String> getUltimoTransportador();
}
