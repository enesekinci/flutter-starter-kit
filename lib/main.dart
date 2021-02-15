import 'package:flutter/material.dart';
import 'package:flutterstarterkit/core/theme/app_theme.dart';
import 'package:flutterstarterkit/module/main/view/main_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/language/language_manager.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Starter Kit',
      theme: AppTheme.instance.lightTheme,
      darkTheme: AppTheme.instance.darkTheme,
      locale: LanguageManager.instance.locale,
      fallbackLocale: LanguageManager.instance.fallbackLocale,
      translations: LanguageManager.instance,
      home: MainPage(),
    );
  }
}
