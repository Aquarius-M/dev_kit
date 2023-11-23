import 'package:flutter_test/flutter_test.dart';
import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/dev_kit_platform_interface.dart';
import 'package:dev_kit/dev_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDevKitPlatform
    with MockPlatformInterfaceMixin
    implements DevKitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DevKitPlatform initialPlatform = DevKitPlatform.instance;

  test('$MethodChannelDevKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDevKit>());
  });

  test('getPlatformVersion', () async {
    DevKit devKitPlugin = DevKit();
    MockDevKitPlatform fakePlatform = MockDevKitPlatform();
    DevKitPlatform.instance = fakePlatform;

    expect(await devKitPlugin.getPlatformVersion(), '42');
  });
}
