import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:translate_do/controller/splash_controller.dart';

import '../../controller/addcontroller.dart';

class BannerAdScreen extends StatelessWidget {
  final BannerAdController adController = Get.put(BannerAdController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
    
        if (adController.isBannerAdReady.value) {
          return Container(
            alignment: Alignment.center,
            width: adController.bannerAd.size.width.toDouble(),
            height: adController.bannerAd.size.height.toDouble(),
            child: AdWidget(ad: adController.bannerAd),
          );
        } else {
          return Text('Ad is loading...');
        }
      }),
    );
  }
}
