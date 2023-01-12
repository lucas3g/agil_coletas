import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';

class UserAdapter {
  static User fromMap(dynamic map) {
    return User(
      id: IdVO(map['id']),
      cnpj: map['cnpj'],
      name: map['name'],
      login: map['login'],
      password: map['password'],
    );
  }
}
