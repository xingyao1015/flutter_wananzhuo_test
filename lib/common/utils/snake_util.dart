import 'package:flutter/material.dart';

class SnakeUtil {
  static void show(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 2),
    ));
  }
}
