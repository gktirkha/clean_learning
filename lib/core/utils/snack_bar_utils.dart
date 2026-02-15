import 'package:flutter/material.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void showAppSnackBar(String message) {
  scaffoldKey.currentState
    ?..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
