import 'dart:convert';

import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_desc_empresa.dart';

class FuncionarioAdapter {
  static Funcionario fromMap(dynamic map) {
    return Funcionario(
      id: const IdVO(1),
      name: map['NOME'],
      ccusto: map['CCUSTO'],
      empresa: FunEmpresa(
        cnpj: '97.305.890/0001-81',
        nome: (map as Map).containsKey('EMPRESA')
            ? map['EMPRESA']['DESC_EMPRESA']
            : map['DESC_EMPRESA'],
      ),
    );
  }

  static Map<String, dynamic> toMap(Funcionario fun) {
    return {
      'NOME': fun.name.value,
      'CCUSTO': fun.ccusto.value,
      'EMPRESA': {
        'CNPJ': fun.empresa.cnpj,
        'DESC_EMPRESA': fun.empresa.nome,
      },
    };
  }

  static String toJson(Funcionario fun) => json.encode(toMap(fun));
}
