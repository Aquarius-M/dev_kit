import 'package:touch_indicator/touch_indicator.dart' as ti;
import 'package:flutter/material.dart';
import '../../core/pluggable.dart';
import 'icon.dart' as icon;

class TouchIndicator extends StatelessWidget implements PluggableWithNestedWidget {
  const TouchIndicator({super.key});

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  int get index => 0;

  @override
  String get name => '触摸指示器';

  @override
  String get displayName => '触摸指示器';

  @override
  void onTrigger() {}

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(icon.iconBytes);

  @override
  Widget buildNestedWidget(Widget child) {
    return ti.TouchIndicator(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
