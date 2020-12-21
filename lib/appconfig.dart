import 'package:flutter/material.dart';

class AppConfig {
  Color blocBackground = Colors.white;
  Color appDataBackground = Colors.grey[300];
  Color backgroundAppConfigPageOne = Colors.indigo[200];
  Color textColorAppConfigPageOne = Colors.purple[600];
  Color backgroundAppConfigPageTwo = Colors.orange[200];
  Color textColorAppConfigPageTwo = Colors.brown[600];
}

enum Mode {
  light, dark
}

class LightMode {
  Color backGroundColor = Colors.white;
  Color textColor = Colors.black87;
  Color linkColor = Colors.lightGreen;
}

class DarkMode {
  Color backGroundColor = Colors.black87;
  Color textColor = Colors.lightGreen;
  Color linkColor = Colors.white;
}