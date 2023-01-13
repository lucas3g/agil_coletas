import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';

class PlatformDeviceInfo implements IDeviceInfo {
  @override
  Future<DeviceInfo> getDeviceInfo() async {
    //await PlatformDeviceId.getDeviceId
    const id = '8df5421dsf87was';

    return DeviceInfo(deviceID: id);
  }
}
