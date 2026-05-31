import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocaleProvider() {
    loadLocale();
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();

    String langCode = prefs.getString('languageCode') ?? 'en';

    _locale = Locale(langCode);

    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('languageCode', locale.languageCode);

    notifyListeners();
  }
}
