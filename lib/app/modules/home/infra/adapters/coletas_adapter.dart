import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/datas_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/km_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';

class ColetasAdapter {
  static Coletas fromMap(dynamic map) {
    return Coletas(
      id: map['ID'],
      rota: RotaColeta(codigo: map['COD_ROTA'], nome: map['NOME_ROTA']),
      dataMov: map['DATA_MOV'],
      dataColeta: DatasColeta(
        dataHoraInicial: map['DT_HORA_INI'],
        dataHoraFinal: map['DT_HORA_FIM'],
      ),
      motorista: map['MOTORISTA'],
      km: KMColeta(inicial: map['KM_INI'], ffinal: map['KM_FIM']),
      ccusto: map['CCUSTO'],
      particoes: map['PARTICOES'],
      placa: map['PLACA'],
      finalizada: map['FINALIZADA'] == 1 ? true : false,
      enviada: map['ENVIADA'] == 1 ? true : false,
      totalColetado: map['TOTAL_COLETADO'],
    );
  }

  static Coletas empty() {
    return Coletas(
      id: 0,
      rota: RotaColeta(codigo: 0, nome: ''),
      dataMov: '',
      motorista: '',
      dataColeta: DatasColeta(dataHoraInicial: '', dataHoraFinal: ''),
      km: KMColeta(inicial: 0, ffinal: 0),
      ccusto: 0,
      particoes: 0,
      placa: '',
      totalColetado: 0,
      finalizada: false,
      enviada: false,
    );
  }

  static Map<String, dynamic> toMap(Coletas coleta) {
    return {
      'COD_ROTA': coleta.rota.codigo,
      'NOME_ROTA': coleta.rota.nome,
      'DATA_MOV': coleta.dataMov,
      'DT_HORA_INI': coleta.datasColeta.dataHoraInicial,
      'DT_HORA_FIM': coleta.datasColeta.dataHoraFinal,
      'MOTORISTA': coleta.motorista,
      'KM_INI': coleta.km.inical,
      'KM_FIM': coleta.km.ffinal,
      'CCUSTO': coleta.ccusto,
      'PARTICOES': coleta.particoes,
      'PLACA': coleta.placa,
      'FINALIZADA': coleta.finalizada ? 1 : 0,
      'ENVIADA': coleta.enviada ? 1 : 0,
      'TOTAL_COLETADO': coleta.totalColetado,
    };
  }
}
