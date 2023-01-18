import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/types/entity.dart';
import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/quantidade.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/temperatura.dart';
import 'package:result_dart/result_dart.dart';

class TiketClone extends Entity {
  RotaColeta _rota;
  Produtor _produtor;
  int _codProduto;
  String _data;
  int _tiket;
  Quantidade _quantidade;
  double _perDesconto;
  int _ccusto;
  double _crioscopia;
  bool _alizarol;
  String _hora;
  int _particao;
  String _observacao;
  String _placa;
  Temperatura _temperatura;
  int _idColeta;
  int _qtdVezesEditado;

  RotaColeta get rota => _rota;
  void setRota(int cod, String nome) =>
      _rota = RotaColeta(codigo: cod, nome: nome);

  Produtor get produtor => _produtor;
  void setProdutor(
    int cod,
    String nome,
    String mun,
    String uf,
    int codRota,
  ) =>
      _produtor = Produtor(
        id: IdVO(cod),
        nome: nome,
        municipio: mun,
        uf: uf,
        codRota: codRota,
      );

  int get codProduto => _codProduto;
  void setCodProduto(int value) => _codProduto = value;

  String get data => _data;
  void setData(String value) => _data = value;

  int get tiket => _tiket;
  void setTiket(int value) => _tiket = value;

  Quantidade get quantidade => _quantidade;
  void setQuantidade(int value) => _quantidade = Quantidade(value);

  double get perDesconto => _perDesconto;
  void setPerDesconto(double value) => _perDesconto = value;

  int get ccusto => _ccusto;
  void setCCusto(int value) => _ccusto = value;

  double get crioscopia => _crioscopia;
  void setCrioscopia(double value) => _crioscopia = value;

  bool get alizarol => _alizarol;
  void setAlizarol(bool value) => _alizarol = value;

  String get hora => _hora;
  void setHora(String value) => _hora = value;

  int get particao => _particao;
  void setParticao(int value) => _particao = value;

  String get observacao => _observacao;
  void setObservacao(String value) => _observacao = value;

  String get placa => _placa;
  void setPlaca(String value) => _placa = value;

  Temperatura get temperatura => _temperatura;
  void setTemperatura(double value) => _temperatura = Temperatura(value);

  int get idColeta => _idColeta;
  void setIDColeta(int value) => _idColeta = value;

  int get qtdVezesEditado => _qtdVezesEditado;
  void setQtdVezesEditado(int value) => _qtdVezesEditado = value;

  TiketClone({
    required super.id,
    required RotaColeta rota,
    required Produtor produtor,
    required codProduto,
    required data,
    required tiket,
    required quantidade,
    required perDesconto,
    required alizarol,
    required ccusto,
    required crioscopia,
    required hora,
    required particao,
    required observacao,
    required placa,
    required temperatura,
    required idColeta,
    required qtdVezesEditado,
  })  : _rota = RotaColeta(codigo: rota.codigo, nome: rota.nome),
        _produtor = Produtor(
          id: produtor.id,
          nome: produtor.nome,
          municipio: produtor.municipio,
          uf: produtor.uf,
          codRota: produtor.codRota,
        ),
        _codProduto = codProduto,
        _data = data,
        _tiket = tiket,
        _quantidade = Quantidade(quantidade),
        _perDesconto = perDesconto,
        _alizarol = alizarol,
        _ccusto = ccusto,
        _crioscopia = crioscopia,
        _hora = hora,
        _particao = particao,
        _observacao = observacao,
        _placa = placa,
        _temperatura = Temperatura(temperatura),
        _idColeta = idColeta,
        _qtdVezesEditado = qtdVezesEditado;

  @override
  Result<TiketClone, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(quantidade.validate)
        .flatMap(temperatura.validate)
        .pure(this);
  }
}
