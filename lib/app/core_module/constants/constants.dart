// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/funcionario_adapter.dart';
import 'package:flutter_modular/flutter_modular.dart';

const baseUrl = String.fromEnvironment('BASE_URL');
const baseUrlLicense = String.fromEnvironment('BASE_URL_LICENSE');

const pathLogo = 'assets/images/logo.svg';

class GlobalFuncionario {
  GlobalFuncionario._();

  static GlobalFuncionario instance = GlobalFuncionario._();

  Funcionario get user {
    final shared = Modular.get<ILocalStorage>();

    return FuncionarioAdapter.fromMap(
        jsonDecode(shared.getData('funcionario')));
  }
}
