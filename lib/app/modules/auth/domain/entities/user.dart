import 'package:agil_coletas/app/core_module/types/entity.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/user_cnpj.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/user_login.dart';
import 'package:agil_coletas/app/modules/auth/domain/vos/user_password.dart';
import 'package:result_dart/result_dart.dart';

class User extends Entity {
  UserCNPJ _cnpj;
  UserLogin _login;
  UserPassword _password;

  UserCNPJ get cnpj => _cnpj;
  void setCNPJ(String value) => _cnpj = UserCNPJ(value);

  UserLogin get login => _login;
  void setLogin(String value) => _login = UserLogin(value);

  UserPassword get password => _password;
  void setPassword(String value) => _password = UserPassword(value);

  User({
    required super.id,
    required cnpj,
    required login,
    required password,
  })  : _cnpj = UserCNPJ(cnpj),
        _login = UserLogin(login),
        _password = UserPassword(password);

  @override
  Result<User, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(cnpj.validate)
        .flatMap(login.validate)
        .flatMap(password.validate)
        .pure(this);
  }
}
