import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:platform_device_id/platform_device_id.dart';

class PlatformDeviceInfo implements IDeviceInfo {
  @override
  Future<DeviceInfo> getDeviceInfo() async {
    final id = await PlatformDeviceId.getDeviceId;

    return DeviceInfo(deviceID: id ?? '');
  }
}
