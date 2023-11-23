import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dev_kit_platform_interface.dart';

/// An implementation of [DevKitPlatform] that uses method channels.
class MethodChannelDevKit extends DevKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dev_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
