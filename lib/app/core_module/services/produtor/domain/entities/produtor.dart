import 'package:agil_coletas/app/core_module/types/entity.dart';

class Produtor extends Entity {
  String _nome;
  String _municipio;
  String _uf;
  int _codRota;
  int _rotaColeta;

  String get nome => _nome;
  void setNome(String value) => _nome = value;

  String get municipio => _municipio;
  void setMunicipio(String value) => _municipio = value;

  String get uf => _uf;
  void setUF(String value) => _uf = value;

  int get codRota => _codRota;
  void setCodRota(int value) => _codRota = value;

  int get rotaColeta => _rotaColeta;
  void setRotaColeta(int value) => _rotaColeta = value;

  Produtor(
      {required super.id,
      required String nome,
      required String municipio,
      required String uf,
      required int codRota,
      required int rotaColeta})
      : _nome = nome,
        _municipio = municipio,
        _uf = uf,
        _codRota = codRota,
        _rotaColeta = rotaColeta;
}
