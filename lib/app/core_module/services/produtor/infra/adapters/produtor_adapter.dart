import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/vos/id_vo.dart';

class ProdutorAdapter {
  static Produtor fromMap(dynamic map) {
    return Produtor(
      id: IdVO(map['CLIFOR']),
      nome: map['NOME'],
      municipio: map['MUNICIPIO'],
      uf: map['UF'],
      codRota: map['ROTA'],
    );
  }

  static Map<String, dynamic> toMap(Produtor produtor) {
    return {
      'CLIFOR': produtor.id.value,
      'UF': produtor.uf,
      'MUNICIPIO': produtor.municipio,
      'NOME': produtor.nome,
      'ROTA': produtor.codRota,
    };
  }
}
