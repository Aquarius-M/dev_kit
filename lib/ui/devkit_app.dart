import 'package:flutter/material.dart';

final GlobalKey<OverlayState> doKitOverlayKey = GlobalKey<OverlayState>();

class DevKitApp extends StatefulWidget {
  DevKitApp() : super(key: rootKey);

  // 放置dokit悬浮窗的容器
  static GlobalKey rootKey = GlobalKey();

  // 放置应用真实widget的容器
  static GlobalKey appKey = GlobalKey();

  @override
  State<DevKitApp> createState() => _DevKitAppState();
}

class _DevKitAppState extends State<DevKitApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          MediaQuery(
            data: MediaQueryData.fromView(View.of(context)),
            child: ScaffoldMessenger(
              child: Overlay(
                key: doKitOverlayKey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
