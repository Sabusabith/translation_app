import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:translate_do/common/color.dart';
import 'package:translate_do/controller/home_controller.dart';
import 'package:translate_do/controller/mic_controller.dart';
import 'package:translate_do/screens/ads/banner_ad.dart';
import 'package:translator/translator.dart';

import '../../common/languages.dart';
import '../../controller/addcontroller.dart';
import '../../controller/camera_controller.dart';
import '../camera/camera.dart';
// Import the CameraScreenController

class Home extends StatelessWidget {
  Home({Key? key});

  final MicController micController = Get.put(MicController());
  final HomeController homeController = Get.put(HomeController());
  final CameraScreenController cameraController = Get.put(CameraScreenController());
  final TextEditingController textController = TextEditingController();
    final BannerAdController adController = Get.put(BannerAdController());

  DateTime? lastPressed;
final adBanner =  BannerAdScreen();
  @override
  Widget build(BuildContext context) {

    String getLanguageName(String code) {
      for (var language in languages) {
        
        if (language['code'] == code) {
          return language['name']!;
        }
      }
      return 'Unknown'; // Fallback if language code is not found
    }

    Future<void> translateText(
        String text, String sourceLanguage, String targetLanguage) async {
      showLoadingDialog(Get.context!);
      try {
        final translator = GoogleTranslator();
        final translation = await translator.translate(text,
            from: sourceLanguage, to: targetLanguage);
        final translatedText = translation.text;
        print('Translated Text: $translatedText');
        hideLoadingDialog(Get.context!);
        String targetLanguageName = getLanguageName(targetLanguage);
        _showBottomSheet(Get.context!, translatedText, targetLanguageName);
      } catch (e) {
        hideLoadingDialog(Get.context!);
        print('Error during translation: $e');
      }
    }

    Size size = MediaQuery.of(context).size;
    return WillPopScope(onWillPop: ()=>onWillPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kbgcolor2,
        appBar: AppBar(
          leading: SizedBox(),
          backgroundColor: kbgcolor2,
          centerTitle: true,
          title: Text(
            "TransWave",
            style: GoogleFonts.dmMono(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                micController.textController.clear();
              },
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 25,
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
              onTap: () async {
                await _scanTextFromCamera(context);
              },
              child: Icon(
                CupertinoIcons.camera_viewfinder,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: size.width,
                    height: size.height,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      cursorColor: Colors.blue.withOpacity(.8),
                      controller: micController.textController,
                      onChanged: (text) {
                        micController.recognizedText.value = text;
                      },
                      onTap: () {
                        homeController.setFieldTap(true);
                      },
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 2,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        hintText: "Enter text here",
                      ),
                      maxLines: 1000,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                          FocusScope.of(context).unfocus();
                          final textToTranslate =
                              micController.textController.text;
                          final sourceLanguage =
                              homeController.selectedLanguageCode;
                          final targetLanguage =
                              homeController.targetLanguage.value;
                          translateText(
                              textToTranslate, sourceLanguage, targetLanguage);
                        },
                        child: Icon(
                          Icons.arrow_circle_right_rounded,
                          color: Colors.blue.withOpacity(.9),
                          size: 55,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: kbgcolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await micController
                              .handleTap(homeController.selectedLanguageCode);
                          FocusScope.of(context).unfocus();
                        },
                        child: Obx(
                          () => micController.tapped.value
                              ? AvatarGlow(
                                  glowColor: Colors.blue.withOpacity(.8),
                                  glowShape: BoxShape.circle,
                                  animate: true,
                                  curve: Curves.bounceInOut,
                                  duration: Duration(milliseconds: 2000),
                                  repeat: true,
                                  child: Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: kbuttoncolor,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.app_fill,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue.withOpacity(.8),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.mic_fill,
                                    color: Colors.grey.shade200,
                                    size: 35,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Obx(
                            () => Expanded(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.black.withOpacity(.8),
                                isExpanded: true,
                                value: homeController.selectedLanguageCode,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    homeController.setSelectedLanguage(newValue);
                                  }
                                },
                                items: languages.map<DropdownMenuItem<String>>(
                                  (Map<String, String> language) {
                                    return DropdownMenuItem<String>(
                                      value: language['code'],
                                      child: Text(
                                        language['name']!,
                                        style: TextStyle(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Add functionality for the second dropdown here
                            },
                            child: Image.asset(
                              "assets/images/switch.png",
                            ),
                          ),
                          Obx(
                            () => Expanded(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.black.withOpacity(.8),
                                isExpanded: true,
                                value: homeController.targetLanguageCode,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    homeController.setTargetLanguage(newValue);
                                  }
                                },
                                items: languages.map<DropdownMenuItem<String>>(

                                  (Map<String, String> language) {
                                    return DropdownMenuItem<String>(
                                      value: language['code'],
                                      child: Text(
                                        language['name']!,
                                        style: TextStyle(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _scanTextFromCamera(BuildContext context) async {
    final result = await Get.to(() => CameraScreen());

    if (result != null) {
      micController.textController.text = result;
      micController.recognizedText.value = result;
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [Colors.blue.withOpacity(.8)],
              ),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _showBottomSheet(
      BuildContext context, String translatedText, String targetlang) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the modal to use more space
      backgroundColor: Color(0xff1f1f21), // Makes the background transparent
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: BoxDecoration(
            color: kbgcolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children:[ Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15),
                      Spacer(),
                      Text(
                        targetlang,
                        style: GoogleFonts.dmMono(
                          color: Colors.blue.withOpacity(.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey.shade700,
                        thickness: .5,
                      )),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Text(
                            translatedText,
                            style: GoogleFonts.dmMono(
                              color: Colors.grey.shade200,
                              fontSize: 16,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
           adController.isBannerAdReady.value? Positioned(right: 0,left: 0,bottom: 5,child: Center(child: BannerAdScreen())):SizedBox()
         ] ),
        );
      },
    );
  }
   Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (lastPressed == null || now.difference(lastPressed!) > Duration(seconds: 2)) {
      lastPressed = now;
      Get.snackbar(
        'Press Back Again to Exit',
        
        '',
        colorText: Colors.grey.shade200,

        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return Future.value(false);
    }
        SystemNavigator.pop();

    return Future.value(true);
  }
}



