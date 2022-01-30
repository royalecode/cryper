import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int SYSTEM_THEME = 1;
const int DARK_THEME = 2;
const int LIGHT_THEME = 3;

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode selectedMode = ThemeMode.system;

  ThemeModeProvider() {
    loadThemeMode().then((value) => selectedMode = value);
  }

  ThemeMode getTheme(){
    return selectedMode;
  }

  Future<int> getSelectedTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("themeMode")) {
      print(prefs.getInt("themeMode"));
      if (prefs.getInt("themeMode") == SYSTEM_THEME) {
        return SYSTEM_THEME;
      }
      if (prefs.getInt("themeMode") == DARK_THEME) {
        return DARK_THEME;
      }
      if (prefs.getInt("themeMode") == LIGHT_THEME) {
        return LIGHT_THEME;
      }
    }
    return SYSTEM_THEME;
  }

  Future<ThemeMode> loadThemeMode() async {
    int theme = await getSelectedTheme();
    if (theme == LIGHT_THEME) {
      return ThemeMode.light;
    }
    if (theme == DARK_THEME) {
      return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  void setSelectedTheme(ThemeMode themeMode) {
    selectedMode = themeMode;
    notifyListeners();
    SharedPreferences.getInstance().then((pref) {
      switch (selectedMode) {
        case ThemeMode.system:
          pref.setInt("themeMode", SYSTEM_THEME);
          break;
        case ThemeMode.light:
          pref.setInt("themeMode", LIGHT_THEME);
          break;
        case ThemeMode.dark:
          pref.setInt("themeMode", DARK_THEME);
          break;
      }
    });
  }
}
