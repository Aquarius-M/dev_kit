import 'package:flutter/material.dart';

import '../ui/devkit_app.dart';

// ignore: must_be_immutable
class DevKitBtn extends StatefulWidget {
  DevKitBtn() : super(key: doKitBtnKey);
  static GlobalKey<State<DevKitBtn>> doKitBtnKey = GlobalKey<State<DevKitBtn>>();

  OverlayEntry? overlayEntry;

  @override
  // ignore: no_logic_in_create_state
  State<DevKitBtn> createState() => _DevKitBtnState(overlayEntry!);

  void addToOverlay() {
    assert(overlayEntry == null);
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return this;
    });
    final OverlayState? rootOverlay = doKitOverlayKey.currentState;
    assert(rootOverlay != null);
    rootOverlay?.insert(overlayEntry!);
  }
}

class _DevKitBtnState extends State<DevKitBtn> {
  final OverlayEntry owner;

  _DevKitBtnState(this.owner);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
    );
  }
}
