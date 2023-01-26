// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_string_interpolations
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/connectivity/connectivity_service.dart';
import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/adapters/license_adapter.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';

class LicenseDatasource implements ILicenseDatasource {
  final IClientHttp clientHttp;
  final ISQLFliteStorage storage;

  LicenseDatasource({
    required this.clientHttp,
    required this.storage,
  });

  @override
  Future<Map<String, dynamic>> verifyLicense(DeviceInfo deviceInfo) async {
    if (!await ConnectivityService.hasWiFi() &&
        !await ConnectivityService.has4G()) {
      throw const MyException(
          message: 'Você precisa estar com internet para acessar.');
    }

    clientHttp.setHeaders({'cnpj': 'licenca', 'id': deviceInfo.deviceID});

    final response = await clientHttp.get('$baseUrlLicense/licenca');

    await Future.delayed(const Duration(milliseconds: 600));

    if (response.statusCode != 200) {
      throw MyException(
        message: 'Error ao tentar verificar licença',
        stackTrace: StackTrace.current,
      );
    }

    clientHttp.setHeaders({'Content-Type': 'application/json'});

    return response.data;
  }

  @override
  Future<bool> saveLicense() async {
    final deleteParam = SQLFliteDeleteAllParam(table: Tables.license);

    await storage.deleteAll(deleteParam);

    final params = SQLFliteRawInsertParam(sql: LicenseAdapter.toInsertSQL());

    final response = await storage.rawCreate(params);

    return response > 0;
  }

  @override
  Future<List<Map<String, dynamic>>> getDateLicense() async {
    final param = SQLFliteGetAllParam(table: Tables.license);

    final result = await storage.getAll(param);

    return result;
  }
}
