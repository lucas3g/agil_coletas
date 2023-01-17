import 'package:agil_coletas/app/core_module/types/entity.dart';

class Transportador extends Entity {
  String _placa;
  String _descricao;
  int _particoes;
  bool _ultimo;

  String get placa => _placa;
  void setPlaca(String value) => _placa = value;

  String get descricao => _descricao;
  void setDescricao(String value) => _descricao = value;

  int get particoes => _particoes;
  void setParticoes(int value) => _particoes = value;

  bool get ultimo => _ultimo;
  void setUltimo(bool value) => _ultimo = value;

  Transportador({
    required super.id,
    required String placa,
    required String descricao,
    required int particoes,
    bool? ultimo,
  })  : _placa = placa,
        _descricao = descricao,
        _particoes = particoes,
        _ultimo = ultimo!;
}
