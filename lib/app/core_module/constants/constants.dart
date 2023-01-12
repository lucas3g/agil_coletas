// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:flutter_modular/flutter_modular.dart';

const baseUrl = String.fromEnvironment('BASE_URL');
const baseUrlLicense = String.fromEnvironment('BASE_URL_LICENSE');

class GlobalUser {
  GlobalUser._();

  static GlobalUser instance = GlobalUser._();

  User get user {
    final shared = Modular.get<ILocalStorage>();

    final result = shared.getData('user');

    if (result != null) {
      final user = UserAdapter.fromMap(jsonDecode(result));
      return user;
    }

    return User(
      id: const IdVO('1'),
      cnpj: '',
      name: '',
      login: '',
      password: '',
    );
  }
}
