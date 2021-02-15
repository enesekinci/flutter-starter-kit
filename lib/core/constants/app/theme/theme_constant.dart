import 'package:flutter/material.dart';

class ThemeConstant {
  static ThemeConstant _instance = ThemeConstant._init();
  static ThemeConstant get instance {
    if (_instance == null) _instance = ThemeConstant._init();
    return _instance;
  }

  ThemeConstant._init();
  final hintTextStyle = TextStyle(
    color: Colors.white54,
    fontFamily: 'OpenSans',
  );

  final errorStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
  );

  final labelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final boxDecorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}
