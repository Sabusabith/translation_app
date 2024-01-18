import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translate_do/common/color.dart';
import 'package:translate_do/controller/splash_controller.dart';

class Splash extends StatelessWidget {
  Splash({super.key});
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kbgcolor,
      body: SafeArea(
        child: GetBuilder<SplashController>(
          init: splashController.timer(),
          builder: (controller) => SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
