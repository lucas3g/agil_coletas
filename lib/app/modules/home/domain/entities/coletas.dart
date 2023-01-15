// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/types/entity.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/km_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';

class Coletas extends Entity {
  RotaColeta _rota;
  String _dataMov;
  KMColeta _km;
  String _placa;
  int _totalColeta;
  bool _finalizada;
  bool _enviada;

  RotaColeta get rota => _rota;
  void setRota(int codRota, String nomeRota) =>
      _rota = RotaColeta(rota: codRota, nome: nomeRota);

  String get dataMov => _dataMov;
  void setDataMov(String value) => _dataMov = value;

  KMColeta get km => _km;
  void setKM(int kmIni, int kmFim) =>
      _km = KMColeta(inicial: kmIni, ffinal: kmFim);

  String get placa => _placa;
  void setPlaca(String value) => _placa = value;

  int get totalColetado => _totalColeta;
  void setTotalColetado(int value) => _totalColeta = value;

  bool get finalizada => _finalizada;
  void setFinalizada(bool value) => _finalizada = value;

  bool get enviada => _enviada;
  void setEnviada(bool value) => _enviada = value;

  Coletas({
    required super.id,
    required RotaColeta rota,
    required String dataMov,
    required KMColeta km,
    required String placa,
    required int totalColetado,
    required bool finalizada,
    required bool enviada,
  })  : _rota = rota,
        _dataMov = dataMov,
        _km = km,
        _placa = placa,
        _totalColeta = totalColetado,
        _finalizada = finalizada,
        _enviada = enviada;
}
