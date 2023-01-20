import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';

class RotasAdapter {
  static Rotas fromMap(dynamic map) {
    return Rotas(
      id: IdVO(map['ID']),
      descricao: map['DESCRICAO'],
      transportador: map['TRANSPORTADOR'],
      finalizada: true,
    );
  }

  static Map<String, dynamic> toMapSQL(Rotas rotas) {
    return {
      'ID': rotas.id.value,
      'DESCRICAO': rotas.descricao,
      'TRANSPORTADOR': rotas.transportador,
      'ROTA_FINALIZADA': rotas.finalizada ? 1 : 0,
    };
  }

  static String toInsertSQL(Rotas rota) {
    return "INSERT INTO ROTAS(ID, DESCRICAO, TRANSPORTADOR, ROTA_FINALIZADA) VALUES(${rota.id.value},'${rota.descricao}', '${rota.transportador}', ${rota.finalizada ? 1 : 0})";
  }
}
