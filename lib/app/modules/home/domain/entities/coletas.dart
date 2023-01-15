// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/vos/km_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';

class Coletas {
  final RotaColeta _rota;
  final String _dataMov;
  final KMColeta _km;
  final String _placa;
  final int _totalColeta;
  final bool _finalizada;
  final bool _enviada;

  RotaColeta get rota => _rota;
  String get dataMov => _dataMov;
  KMColeta get km => _km;
  String get placa => _placa;
  int get totalColetado => _totalColeta;
  bool get finalizada => _finalizada;
  bool get enviada => _enviada;

  Coletas({
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
