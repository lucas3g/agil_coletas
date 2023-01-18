import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';

abstract class IRotasDatasource {
  Future<String> getRotasOnline();
  Future<List> getRotasOffline();
  Future<List> getRotasNaoFinalizadas();
  Future<bool> saveRotas(List<Rotas> rotas);
}
