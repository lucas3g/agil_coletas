import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';

abstract class LicenseEvents {}

class VerifyLicenseEvent extends LicenseEvents {
  final DeviceInfo deviceInfo;

  VerifyLicenseEvent({
    required this.deviceInfo,
  });
}

class SaveLicenseEvent extends LicenseEvents {}

class GetDateLicenseEvent extends LicenseEvents {}
