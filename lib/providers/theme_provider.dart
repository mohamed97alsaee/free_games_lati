import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = false;

  // initialTheme() {
  //   isDark = false;
  //   notifyListeners();
  // }

  switchMode() {
    isDark = !isDark;
    notifyListeners();
  }
}
