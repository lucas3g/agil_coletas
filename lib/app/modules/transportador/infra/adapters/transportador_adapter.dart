import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';

class TransportadorAdapter {
  static Transportador fromMap(dynamic map) {
    return Transportador(
      id: IdVO(map['ID'] ?? 1),
      placa: map['PLACA'],
      descricao: map['DESCRICAO'],
      particoes: map['TANQUES'],
      ultimo: false,
    );
  }

  static Map<String, dynamic> toMapSQL(Transportador transp) {
    return {
      'ID': transp.id.value,
      'DESCRICAO': transp.descricao,
      'PLACA': transp.placa,
      'TANQUES': transp.particoes,
    };
  }

  static String toInsertSQL(Transportador transp) {
    return "INSERT INTO CAMINHOES(PLACA, DESCRICAO, TANQUES) VALUES ('${transp.placa}', '${transp.descricao}', ${transp.particoes})";
  }
}
