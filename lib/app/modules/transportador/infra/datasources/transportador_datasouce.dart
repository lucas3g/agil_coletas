import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';

abstract class ITransportadorDatasource {
  Future<String> getTransportadorOnline();
  Future<List> getTransportadorOffline();
  Future<String> getUltimoTransportador();
  Future<bool> removeAll();
  Future<bool> saveTransportadores(List<Transportador> transportadores);
}
