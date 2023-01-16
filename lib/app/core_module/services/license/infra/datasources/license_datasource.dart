import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';

abstract class ILicenseDatasource {
  Future<Map<String, dynamic>> verifyLicense(DeviceInfo deviceInfo);
  Future<bool> saveLicense();
}
