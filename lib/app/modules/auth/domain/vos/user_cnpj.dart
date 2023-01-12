import 'package:agil_coletas/app/core_module/vos/text_vo.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:result_dart/result_dart.dart';

class UserCNPJ extends TextVO {
  UserCNPJ(super.value);

  @override
  Result<UserCNPJ, String> validate([Object? object]) {
    if (!CNPJValidator.isValid(value)) {
      return 'CNPJ inválido'.toFailure();
    }

    return toSuccess();
  }
}
