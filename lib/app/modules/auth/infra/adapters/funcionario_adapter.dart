import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';

class FuncionarioAdapter {
  static Funcionario fromMap(dynamic map) {
    return Funcionario(
      id: const IdVO(1),
      name: map['NOME'],
      ccusto: map['CCUSTO'],
      empresa: map['DESC_EMPRESA'],
    );
  }
}
