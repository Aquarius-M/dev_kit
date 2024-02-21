import 'dart:convert';

import 'package:base_utils/app_info/sqlite/viewer.dart';
import 'package:dev_kit/core/pluggable.dart';
import 'package:flutter/material.dart';
import 'icon.dart' as icon;

class DatabasePluggable extends StatelessWidget implements Pluggable {
  const DatabasePluggable({super.key});

  @override
  Widget build(BuildContext context) {
    return const SqliteViewPage();
  }

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  String get displayName => '数据库';

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(base64Decode(icon.iconData));

  @override
  String get name => '数据库';

  @override
  int get index => 8;

  @override
  void onTrigger() {}
}
