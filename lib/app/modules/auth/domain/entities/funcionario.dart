import 'package:agil_coletas/app/core_module/types/entity.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_ccusto.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_desc_empresa.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/fun_name.dart';

class Funcionario extends Entity {
  FunName _name;
  FunCCUSTO _ccusto;
  FunDescEmpresa _empresa;

  FunName get name => _name;
  void setName(String value) => _name = FunName(value);

  FunCCUSTO get ccusto => _ccusto;
  void setCCusto(int value) => _ccusto = FunCCUSTO(value);

  FunDescEmpresa get empresa => _empresa;
  void setEmpresa(String value) => _empresa = FunDescEmpresa(value);

  Funcionario({
    required super.id,
    required name,
    required ccusto,
    required empresa,
  })  : _name = FunName(name),
        _ccusto = FunCCUSTO(ccusto),
        _empresa = FunDescEmpresa(empresa);
}
