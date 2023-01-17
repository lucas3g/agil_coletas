import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

class TiketAdapter {
  static Map<String, dynamic> toMapSQLFlite(Produtor produtor) {
    return {
      'CLIFOR': produtor.id.value,
      'UF': produtor.uf,
      'MUNICIPIOS': produtor.municipio,
      'NOME': produtor.nome,
      'PRODUTO': 0,
      'DATA': '${'"${DateTime.now().DiaMesAnoDB()}'}"',
      'TIKET': 1,
      'QUANTIDADE': 0,
      'PER_DESCONTO': 0.0,
      'CCUSTO': 0,
      'ROTA_COLETA': 0,
      'ID_COLETA': 0,
      'CRIOSCOPIA': 0,
      'ALIZAROL': 0,
      'HORA':
          '"${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}"',
      'PARTICAO': 1,
      'OBSERVACAO': '',
      'PLACA': '',
      'TEMPERATURA': 0,
      'QTD_VEZES_EDITADO': 0,
    };
  }

  static Tiket fromMap(dynamic map) {
    return Tiket(
      id: map['ID'],
      rota: map['ROTA'],
      produtor: map['PRODUTOR'],
      codProduto: map['PRODUTO'],
      data: map['DATA'],
      tiket: map['TIKET'],
      quantidade: map['QUANTIDADE'],
      perDesconto: map['PER_DESCONTO'],
      alizarol: map['ALIZAROL'],
      ccusto: map['CCUSTO'],
      crioscopia: map['CRIOSCOPIA'],
      hora: map['HORA'],
      particao: map['PARTICAO'],
      observacao: map['OBSERVACAO'],
      placa: map['PLACA'],
      temperatura: map['TEMPERATURA'],
      idColeta: map['ID_COLETA'],
      qtdVezesEditado: map['QTD_VEZES_EDITADO'],
    );
  }
}
