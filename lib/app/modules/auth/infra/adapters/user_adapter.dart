import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';

class UserAdapter {
  static User fromMap(dynamic map) {
    return User(
      id: IdVO(map['id']),
      cnpj: map['cnpj'],
      login: map['login'],
      password: map['password'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'CNPJ': user.cnpj.value,
      'USUARIO': user.login.value,
      'SENHA': user.password.value,
    };
  }

  static User empty() {
    return User(id: const IdVO(1), cnpj: '', login: '', password: '');
  }
}
