
import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreenController extends ChangeNotifier{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isDarkMode = false;

Future<void> setMode(bool darkMode) async {
  final SharedPreferences prefs = await _prefs;
  if (darkMode) {
    prefs.setBool('theme', darkMode);
  } else {
    prefs.setBool('theme', darkMode);
  }
  MyApp.themeNotifier.value =
  MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

  isDarkMode;
  notifyListeners();
  }
}