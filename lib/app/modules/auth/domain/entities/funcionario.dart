import 'package:agil_coletas/app/core_module/types/entity.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_ccusto.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_desc_empresa.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_name.dart';

class Funcionario extends Entity {
  FunName _name;
  FunCCUSTO _ccusto;
  FunEmpresa _empresa;

  FunName get name => _name;
  void setName(String value) => _name = FunName(value);

  FunCCUSTO get ccusto => _ccusto;
  void setCCusto(int value) => _ccusto = FunCCUSTO(value);

  FunEmpresa get empresa => _empresa;
  void setEmpresa(String cnpj, String nome) =>
      _empresa = FunEmpresa(cnpj: cnpj, nome: nome);

  Funcionario({
    required super.id,
    required name,
    required ccusto,
    required FunEmpresa empresa,
  })  : _name = FunName(name),
        _ccusto = FunCCUSTO(ccusto),
        _empresa = FunEmpresa(cnpj: empresa.cnpj, nome: empresa.nome);
}
