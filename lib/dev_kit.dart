
import 'dev_kit_platform_interface.dart';

class DevKit {
  Future<String?> getPlatformVersion() {
    return DevKitPlatform.instance.getPlatformVersion();
  }
}
