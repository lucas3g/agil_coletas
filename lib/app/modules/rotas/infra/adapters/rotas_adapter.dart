import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';

class RotasAdapter {
  static Rotas fromMap(dynamic map) {
    return Rotas(
      id: IdVO(map['ID']),
      descricao: map['DESCRICAO'],
      transportador: map['TRANSPORTADOR'],
    );
  }
}
