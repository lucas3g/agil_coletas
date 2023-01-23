import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';

abstract class AuthEvents {}

class SignInAuthEvent extends AuthEvents {
  final User user;

  SignInAuthEvent({
    required this.user,
  });
}

class SignOutUserEvent extends AuthEvents {}

class VerifyLicenseEvent extends AuthEvents {
  final DeviceInfo deviceInfo;

  VerifyLicenseEvent({
    required this.deviceInfo,
  });
}

class SaveLicenseEvent extends AuthEvents {}

class GetDateLicenseEvent extends AuthEvents {}
