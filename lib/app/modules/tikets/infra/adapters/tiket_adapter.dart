import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/domain/vos/rota_coleta.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket_clone.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

class TiketAdapter {
  static Map<String, dynamic> toMapSQLFlite(Produtor produtor, Coletas coleta) {
    return {
      'ID_COLETA': coleta.id,
      'CLIFOR': produtor.id.value,
      'UF': produtor.uf,
      'MUNICIPIO': produtor.municipio,
      'NOME': produtor.nome,
      'PRODUTO': 0,
      'DATA': '${'"${DateTime.now().DiaMesAnoDB()}'}"',
      'TIKET': 1,
      'QUANTIDADE': 0,
      'PER_DESCONTO': 0.0,
      'CCUSTO': coleta.ccusto,
      'ROTA_COLETA': coleta.rota.codigo,
      'CRIOSCOPIA': 0,
      'ALIZAROL': 0,
      'HORA':
          '"${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}"',
      'PARTICAO': 1,
      'OBSERVACAO': '',
      'PLACA': coleta.placa,
      'TEMPERATURA': 0.0,
      'QTD_VEZES_EDITADO': 0,
    };
  }

  static Tiket fromMap(dynamic map) {
    return Tiket(
      id: IdVO(map['ID']),
      rota: RotaColeta(codigo: map['ROTA_COLETA'], nome: ''),
      produtor: Produtor(
        id: IdVO(map['CLIFOR']),
        nome: map['NOME'],
        municipio: map['MUNICIPIO'],
        uf: map['UF'],
        codRota: map['ROTA_COLETA'],
      ),
      codProduto: map['PRODUTO'],
      data: map['DATA'],
      tiket: map['TIKET'],
      quantidade: map['QUANTIDADE'],
      perDesconto: map['PER_DESCONTO'],
      alizarol: map['ALIZAROL'] == 0 ? false : true,
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

  static TiketClone toTiketClone(Tiket tiket) {
    return TiketClone(
      id: tiket.id,
      rota: tiket.rota,
      produtor: tiket.produtor,
      codProduto: tiket.codProduto,
      data: tiket.data,
      tiket: tiket.tiket,
      quantidade: tiket.quantidade.value,
      perDesconto: tiket.perDesconto,
      alizarol: tiket.alizarol,
      ccusto: tiket.ccusto,
      crioscopia: tiket.crioscopia,
      hora: tiket.hora,
      particao: tiket.particao,
      observacao: tiket.observacao,
      placa: tiket.placa,
      temperatura: tiket.temperatura.value,
      idColeta: tiket.idColeta,
      qtdVezesEditado: tiket.qtdVezesEditado,
    );
  }

  static Map<String, dynamic> toMapUpdate(Tiket tiket) {
    return {
      'ID_COLETA': tiket.idColeta,
      'CLIFOR': tiket.produtor.id.value,
      'UF': tiket.produtor.uf,
      'MUNICIPIO': tiket.produtor.municipio,
      'NOME': tiket.produtor.nome,
      'PRODUTO': tiket.codProduto,
      'DATA': '${'"${DateTime.now().DiaMesAnoDB()}'}"',
      'TIKET': tiket.tiket,
      'QUANTIDADE': tiket.quantidade.value,
      'PER_DESCONTO': tiket.perDesconto,
      'CCUSTO': tiket.ccusto,
      'ROTA_COLETA': tiket.rota.codigo,
      'CRIOSCOPIA': tiket.crioscopia,
      'ALIZAROL': tiket.alizarol ? 1 : 0,
      'HORA':
          '"${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}"',
      'PARTICAO': tiket.particao,
      'OBSERVACAO': tiket.observacao,
      'PLACA': tiket.placa,
      'TEMPERATURA': tiket.temperatura.value,
      'QTD_VEZES_EDITADO': tiket.qtdVezesEditado + 1,
    };
  }
}
