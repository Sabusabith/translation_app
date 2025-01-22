import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translate_do/screens/splash/splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
void main(List<String> args) {
    WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(GetMaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}