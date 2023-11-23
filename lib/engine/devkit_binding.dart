import 'package:flutter/material.dart';

class DevKitWidgetsFlutterBinding extends WidgetsFlutterBinding {
  static WidgetsBinding? ensureInitialized() {
    return WidgetsBinding.instance;
  }
}
