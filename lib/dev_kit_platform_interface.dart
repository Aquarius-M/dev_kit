import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dev_kit_method_channel.dart';

abstract class DevKitPlatform extends PlatformInterface {
  /// Constructs a DevKitPlatform.
  DevKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static DevKitPlatform _instance = MethodChannelDevKit();

  /// The default instance of [DevKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelDevKit].
  static DevKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DevKitPlatform] when
  /// they register themselves.
  static set instance(DevKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
