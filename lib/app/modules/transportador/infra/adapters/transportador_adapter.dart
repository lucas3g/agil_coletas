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
}
