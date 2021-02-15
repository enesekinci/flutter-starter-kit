import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageManager extends Translations {
  static LanguageManager _instance;
  static LanguageManager get instance {
    if (_instance == null) _instance = LanguageManager._init();
    return _instance;
  }

  LanguageManager._init();

  final locale = Locale('tr', 'TR');
  final enLocale = Locale("en", "US");
  final fallbackLocale = Locale('tr', 'TR');

  final langs = [
    'English',
    'Türkçe',
    '日本語',
  ];

  final locales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
    Locale('ja', 'JP'),
  ];

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'tr_TR': trTR,
        'ja_JP': jaJP,
      };

  // English Translations
  final Map<String, String> enUS = {
    'hello': 'Hello!',
  };

  // Japanese Translations
  final Map<String, String> jaJP = {
    'hello': '今日は!',
  };

  // Turkish Translations
  final Map<String, String> trTR = {
    'hello': 'Merhaba!',
  };
}
