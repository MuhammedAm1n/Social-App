import 'package:flutter/material.dart';
import 'package:social/PresentaionLayer/Component/Themes/Dark.dart';
import 'package:social/PresentaionLayer/Component/Themes/Light.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = LightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == LightMode) {
      themeData = DarkMode;
    } else {
      themeData = LightMode;
    }
  }
}
