import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicController extends GetxController {
  var tapped = false.obs;
  RxString recognizedText = "Enter text here".obs;
  late TextEditingController textController;
  late stt.SpeechToText _speech;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    textController = TextEditingController();
  }

  Future<void> handleTap(String sourceLanguage) async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print("Speech status: $status");
        },
        onError: (error) {
          print("Speech error: $error");
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              print("Speech result: ${result.recognizedWords}");
              recognizedText.value = result.recognizedWords;
              textController.text = recognizedText.value;
              Get.focusScope!.requestFocus(FocusNode());
            }
          },
          localeId: sourceLanguage,  // Add this line to specify the source language
        );
        tapped.value = true;
      } else {
        print("Speech initialization failed");
      }
    } else {
      _speech.stop();
      tapped.value = false;
    }
  }
}
