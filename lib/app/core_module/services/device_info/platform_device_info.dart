import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';

class PlatformDeviceInfo implements IDeviceInfo {
  @override
  Future<DeviceInfo> getDeviceInfo() async {
    //await PlatformDeviceId.getDeviceId
    const id = '4bb4e14f9a057ad5';

    return DeviceInfo(deviceID: id);
  }
}
