import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';

class ProdutorAdapter {
  static Produtor fromMap(dynamic map) {
    return Produtor(
      id: map['CLIFOR'],
      nome: map['NOME'],
      municipio: map['MUNICIPIOS'],
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
