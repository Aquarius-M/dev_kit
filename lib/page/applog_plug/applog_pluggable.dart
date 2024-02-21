import 'dart:convert';

import 'package:dev_kit/core/pluggable.dart';
import 'package:flutter/material.dart';
import 'app_log.dart';
import 'icon.dart' as icon;

class ApplogPluggable extends StatelessWidget implements Pluggable {
  const ApplogPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  String get displayName => '日志信息';

  @override
  ImageProvider<Object> get iconImageProvider =>
      MemoryImage(base64Decode(icon.iconData));

  @override
  String get name => '日志信息';

  @override
  int get index => 7;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const LogListPage();
  }
}