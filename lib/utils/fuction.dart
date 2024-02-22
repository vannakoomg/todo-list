// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Future unFocus(BuildContext context) async {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
