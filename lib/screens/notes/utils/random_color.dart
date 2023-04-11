import 'dart:math';

import 'package:flutter/material.dart';

Color? randomColor() {
  return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
}

extension StringExt on String {
  Color toColor() {
    final hexCode = split("(").last.replaceAll(")", "").substring(2);
    return Color(int.tryParse(hexCode, radix: 16) ?? 0xFFFFFF);
  }
}
