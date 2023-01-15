import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/km_coleta.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';

class ColetasAdapter {
  static Coletas fromMap(dynamic map) {
    return Coletas(
      rota: RotaColeta(rota: map['COD_ROTA'], nome: map['NOME_ROTA']),
      dataMov: map['DATA_MOV'],
      km: KMColeta(inicial: map['KM_INI'], ffinal: map['KM_FIM']),
      placa: map['PLACA'],
      totalColetado: map['TOTAL_COLETADO'],
      finalizada: map['FINALIZADA'],
      enviada: map['ENVIADA'],
    );
  }
}
