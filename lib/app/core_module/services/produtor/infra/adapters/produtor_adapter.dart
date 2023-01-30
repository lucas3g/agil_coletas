import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/vos/id_vo.dart';

class ProdutorAdapter {
  static Produtor fromMap(dynamic map) {
    return Produtor(
      id: IdVO(map['CLIFOR']),
      nome: map['NOME'],
      municipio: map['MUNICIPIOS'],
      uf: map['UF'],
      codRota: map['ROTA'],
      rotaColeta: map['ROTA_COLETA'] ?? 0,
    );
  }

  static Map<String, dynamic> toMap(Produtor produtor) {
    return {
      'CLIFOR': produtor.id.value,
      'UF': produtor.uf,
      'MUNICIPIOS': produtor.municipio,
      'NOME': produtor.nome,
      'ROTA': produtor.codRota,
      'ROTA_COLETA': produtor.rotaColeta,
    };
  }

  static String toInsertSQL(Produtor produtor) {
    return "INSERT INTO PRODUTORES(CLIFOR, ROTA, NOME, MUNICIPIOS, UF, ROTA_COLETA) VALUES(${produtor.id.value}, ${produtor.codRota}, '${produtor.nome}', '${produtor.municipio}', '${produtor.uf}', ${produtor.rotaColeta})";
  }
}
