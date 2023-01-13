import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';

class FuncionarioAdapter {
  static Funcionario fromMap(dynamic map) {
    return Funcionario(
      id: IdVO(map['id']),
      name: map['nome'],
      ccusto: map['ccusto'],
      empresa: map['empresa'],
    );
  }
}
