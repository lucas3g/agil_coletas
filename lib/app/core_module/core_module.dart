import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/device_info/platform_device_info.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/get_date_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/save_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/external/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/repositories/license_repository.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/make_tables/make_tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_service.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
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
    Bind.factory<ILicenseDatasource>(
      (i) => LicenseDatasource(
        clientHttp: i(),
        storage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<ILicenseRepository>(
      (i) => LicenseRepository(
        datasource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IVerifyLicenseUseCase>(
      (i) => VerifyLicenseUseCase(
        repository: i(),
      ),
      export: true,
    ),
    Bind.factory<ISaveLicenseUseCase>(
      (i) => SaveLicenseUseCase(
        repository: i(),
      ),
      export: true,
    ),
    Bind.factory<IGetDateLicenseUseCase>(
      (i) => GetDateLicenseUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //SQFLITE
    AsyncBind<ISQLFliteStorage>(
      (i) async {
        final service = SQLFliteService();

        final param = SQLFliteInitParam(
          fileName: 'agil.db',
          tables: {
            MakeTables.coletas(),
            MakeTables.tiket(),
            MakeTables.rotas(),
            MakeTables.caminhoes(),
            MakeTables.produtores(),
            MakeTables.license(),
          },
        );

        await service.init(param);

        return service;
      },
      export: true,
    ),
  ];
}
