import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translate_do/screens/splash/splash.dart';

void main(List<String> args) {
  
  runApp(GetMaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}