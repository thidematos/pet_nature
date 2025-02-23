import 'package:flutter/material.dart';

class UiInstances {
  const UiInstances();

  static BoxShadow shadow = BoxShadow(
    color: Colors.grey.withAlpha(15),
    blurRadius: 5,
    spreadRadius: 5,
    offset: Offset(2, 4),
  );

  static EdgeInsets screenPadding = const EdgeInsets.symmetric(
    vertical: 50,
    horizontal: 20,
  );

  static Widget logoToMainContentSpacer = const SizedBox(height: 116);
}
