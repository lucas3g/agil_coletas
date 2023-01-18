// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/vos/datas_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/km_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';

class Coletas {
  int _id;
  RotaColeta _rota;
  String _dataMov;
  DatasColeta _datasColeta;
  String _motorista;
  KMColeta _km;
  int _ccusto;
  int _particoes;
  String _placa;
  bool _finalizada;
  bool _enviada;
  int _totalColeta;

  int get id => _id;
  void setID(int value) => _id = value;

  RotaColeta get rota => _rota;
  void setRota(int codRota, String nomeRota) =>
      _rota = RotaColeta(codigo: codRota, nome: nomeRota);

  String get dataMov => _dataMov;
  void setDataMov(String value) => _dataMov = value;

  DatasColeta get datasColeta => _datasColeta;
  void setDatasColeta({String? dataHoraInicial, String? dataHoraFinal}) =>
      _datasColeta = DatasColeta(
          dataHoraInicial: dataHoraInicial ?? _datasColeta.dataHoraInicial,
          dataHoraFinal: dataHoraFinal ?? _datasColeta.dataHoraFinal);

  KMColeta get km => _km;
  void setKM({int? kmIni, int? kmFim}) =>
      _km = KMColeta(inicial: kmIni ?? _km.inical, ffinal: kmFim ?? _km.ffinal);

  String get motorista => _motorista;
  void setMotorista(String value) => _motorista = value;

  int get particoes => _particoes;
  void setParticoes(int value) => _particoes = value;

  int get ccusto => _ccusto;
  void setCCusto(int value) => _ccusto = value;

  String get placa => _placa;
  void setPlaca(String value) => _placa = value;

  int get totalColetado => _totalColeta;
  void setTotalColetado(int value) => _totalColeta = value;

  bool get finalizada => _finalizada;
  void setFinalizada(bool value) => _finalizada = value;

  bool get enviada => _enviada;
  void setEnviada(bool value) => _enviada = value;

  Coletas({
    required int id,
    required RotaColeta rota,
    required String dataMov,
    required DatasColeta dataColeta,
    required String motorista,
    required KMColeta km,
    required int ccusto,
    required int particoes,
    required String placa,
    required bool finalizada,
    required bool enviada,
    required int totalColetado,
  })  : _id = id,
        _rota = rota,
        _dataMov = dataMov,
        _datasColeta = dataColeta,
        _motorista = motorista,
        _km = km,
        _ccusto = ccusto,
        _particoes = particoes,
        _placa = placa,
        _totalColeta = totalColetado,
        _finalizada = finalizada,
        _enviada = enviada;
}
