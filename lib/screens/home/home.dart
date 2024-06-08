import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:translate_do/common/color.dart';
import 'package:translate_do/controller/home_controller.dart';
import 'package:translate_do/controller/mic_controller.dart';
import 'package:translator/translator.dart';

import '../../common/languages.dart';

class Home extends StatelessWidget {
  Home({Key? key});

  final MicController micController = Get.put(MicController());
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String getLanguageName(String code) {
      for (var language in languages) {
        print("languages $language");
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kbgcolor2,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: kbgcolor2,
        centerTitle: true,
        title: Text(
          "TransWay",
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
          Icon(
            CupertinoIcons.camera_viewfinder,
            color: Colors.white,
            size: 30,
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
                        color:Colors.blue.withOpacity(.9),
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
                        await micController.handleTap(homeController.selectedLanguageCode);
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
                                  print("New value :$newValue");
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
                                        
                                          color: Colors.grey.shade200),
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
                                  print("New value :$newValue");
                                  homeController.setTargetLanguage(newValue);
                                }
                              },
                              items: languages.map<DropdownMenuItem<String>>(
                                (Map<String, String> language) {
                                  return DropdownMenuItem<String>(
                                    value: language['code'],
                                    child: Text(language['name']!,
                                        style: TextStyle(
                                            color: Colors.grey.shade200)),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: SizedBox(
              width: 60,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse, // Required
                colors: [Colors.green], // Optional
              ),
            ),
          ),
        );
      },
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
                      color: Colors.grey.shade300,
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
                          color: Color(0xffa8c7fa),
                          fontSize: 22,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
