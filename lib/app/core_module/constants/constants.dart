import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/funcionario_adapter.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_modular/flutter_modular.dart';

const baseUrl = String.fromEnvironment('BASE_URL');
const baseUrlLicense = String.fromEnvironment('BASE_URL_LICENSE');

const pathLogo = 'assets/images/logo.svg';

class GlobalFuncionario {
  GlobalFuncionario._();

  static GlobalFuncionario instance = GlobalFuncionario._();

  Funcionario get funcionario {
    final shared = Modular.get<ILocalStorage>();

    return FuncionarioAdapter.fromMap(
      jsonDecode(
        shared.getData('funcionario'),
      ),
    );
  }
}

class GlobalDevice {
  GlobalDevice._();

  static GlobalDevice instance = GlobalDevice._();

  DeviceInfo get deviceInfo {
    final shared = Modular.get<ILocalStorage>();

    return DeviceInfo(deviceID: shared.getData('DEVICE_ID'));
  }
}

class GlobalImpressora {
  GlobalImpressora._();

  static GlobalImpressora instance = GlobalImpressora._();

  Impressoras get impressora {
    final shared = Modular.get<ILocalStorage>();

    final imp = shared.getData('imp');

    if (imp != null) {
      return Impressoras.fromMap(jsonDecode(imp));
    }

    return Impressoras(name: 'name', address: 'address');
  }
}

final cnpjSemCaracter = UtilBrasilFields.removeCaracteres(
        GlobalFuncionario.instance.funcionario.empresa.cnpj)
    .substring(0, 8);
