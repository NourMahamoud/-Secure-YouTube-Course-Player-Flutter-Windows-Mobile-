import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'Service/secure_Service/Windows.dart';
import 'Service/shared_preferences/shared_preferences.dart';
import 'View/SplachScreen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenshotBlocker.blockScreenshots();
  }
final SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  await sharedPreferenceHelper.initSharedPreferences();
final lang = await sharedPreferenceHelper.getString('lang');

  runApp( EasyLocalization(
      supportedLocales: [
        Locale('ar', 'EG'),
        Locale('ru', 'RU'),
        ] ,
      path: 'assets/translations',
      startLocale: lang == 'ru'  ? Locale('ru', 'RU') : const Locale('ar', 'EG'),// <-- change the path of the translation files
      fallbackLocale:Locale('ar', 'EG'),
      saveLocale: false,
      child: MyApp()
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home:  Splachscreen(),
    );
  }
}

