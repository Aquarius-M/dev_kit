import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../core/pluggable.dart';
import 'core/channel_binding.dart';
import 'icon.dart' as icon;
import 'ui/channel_pages.dart';

class ChannelPluggable extends Pluggable {
  ChannelPluggable() {
    ChannelBinding.ensureInitialized();
  }

  @override
  Widget buildWidget(BuildContext? context) {
    return const ChannelPages();
  }

  @override
  String get displayName => 'Channel';

  @override
  ImageProvider<Object> get iconImageProvider =>
      MemoryImage(base64Decode(icon.iconData));

  @override
  String get name => 'Channel';

  @override
  void onTrigger() {}

  @override
  int get index => 999994;
}
