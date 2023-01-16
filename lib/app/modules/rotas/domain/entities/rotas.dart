import 'package:agil_coletas/app/core_module/types/entity.dart';

class Rotas extends Entity {
  String _descricao;
  String _transportador;
  bool _finalizada;

  String get descricao => _descricao;
  void setDescricao(String value) => _descricao = value;

  String get transportador => _transportador;
  void setTransportador(String value) => _transportador = value;

  bool get finalizada => _finalizada;
  void setFinalizada(bool value) => _finalizada = value;

  Rotas({
    required super.id,
    required String descricao,
    required String transportador,
    required bool finalizada,
  })  : _descricao = descricao,
        _transportador = transportador,
        _finalizada = finalizada;
}
