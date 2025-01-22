import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdController extends GetxController {
  late BannerAd _bannerAd;
  RxBool isBannerAdReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBannerAd();
  }

  void _loadBannerAd() {
     final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-1839697614477804/7637865833'
    : 'ca-app-pub-1839697614477804/2715769691';
    _bannerAd = BannerAd(
      
      adUnitId: adUnitId, // Test Ad ID
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          isBannerAdReady.value = false;
          print('BannerAd failed to load: $error');
        },
      ),
    )..load();
  }

  BannerAd get bannerAd => _bannerAd;

  @override
  void onClose() {
    _bannerAd.dispose();
    super.onClose();
  }
}
