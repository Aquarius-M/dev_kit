import 'package:dev_kit/widget/devkit_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as dart;

import 'engine/devkit_binding.dart';
import 'ui/devkit_app.dart';

const bool release = kReleaseMode;

class DevKit {
  static Future<void> runApp({
    DevKitApp? app,
    bool useRunZoned = true,
    bool useInRelease = false,
    Function? releaseAction,
  }) async {
    if (release && !useInRelease) {
      if (releaseAction != null) {
        releaseAction.call();
      } else {
        dart.runApp(app!);
      }
      return;
    }
    if (useRunZoned != true) {
      f() async => <void>{
            _runWrapperApp(app!),
            _ensureDoKitBinding(useInRelease: useInRelease),
          };
      await f();
      return;
    }
  }
}

void _runWrapperApp(DevKitApp wrapper) {
  DevKitWidgetsFlutterBinding.ensureInitialized()
    // ignore: invalid_use_of_protected_member
    ?..scheduleAttachRootWidget(wrapper)
    ..scheduleWarmUpFrame();
  addEntrance();
}

void addEntrance() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final DevKitBtn floatBtn = DevKitBtn();
    floatBtn.addToOverlay();
  });
}

void _ensureDoKitBinding({bool useInRelease = false}) {
  if (!release || useInRelease) {
    DevKitWidgetsFlutterBinding.ensureInitialized();
  }
}
