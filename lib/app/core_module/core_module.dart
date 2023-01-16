import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/device_info/platform_device_info.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/external/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/repositories/license_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_preferences/local_storage_interface.dart';
import 'services/shared_preferences/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'services/client_http/client_http_interface.dart';
import 'services/client_http/dio_client_http.dart';

Bind<Dio> _dioFactory() {
  final baseOptions = BaseOptions(
    // baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  );
  return Bind.factory<Dio>((i) => Dio(baseOptions), export: true);
}

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    //DIO
    _dioFactory(),

    //CLIENTHTTP
    Bind.factory<IClientHttp>(
      (i) => DioClientHttp(i()),
      export: true,
    ),

    //SHARED PREFERENCES
    AsyncBind<SharedPreferences>(
      (i) => SharedPreferences.getInstance(),
      export: true,
    ),

    //LOCAL STORAGE
    Bind<ILocalStorage>(
      ((i) => SharedPreferencesService(sharedPreferences: i())),
      export: true,
    ),

    Bind.factory<IDeviceInfo>(
      (i) => PlatformDeviceInfo(),
      export: true,
    ),

    //DATASOURCES
    Bind.singleton<ILicenseDatasource>(
      (i) => LicenseDatasource(
        clientHttp: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.singleton<ILicenseRepository>(
      (i) => LicenseRepository(
        datasource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.singleton<IVerifyLicenseUseCase>(
      (i) => VerifyLicenseUseCase(
        repository: i(),
      ),
      export: true,
    ),

    // AsyncBind<ISQLFliteStorage>(
    //   (i) async {
    //     final service = SQLFliteService();

    //     final param = SQLFliteInitParam(
    //       fileName: 'agil.db',
    //       tables: {
    //         MakeTables.coletas(),
    //         MakeTables.tiket(),
    //       },
    //     );

    //     await service.init(param);

    //     return service;
    //   },
    //   export: true,
    // ),
  ];
}
