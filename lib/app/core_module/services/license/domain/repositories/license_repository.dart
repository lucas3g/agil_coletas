import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/entities/license.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class ILicenseRepository {
  Future<Result<License, IMyException>> verifyLicense(DeviceInfo deviceInfo);
  Future<Result<bool, IMyException>> saveLicense();
  Future<Result<DateTime, IMyException>> getDateLicense();
}
