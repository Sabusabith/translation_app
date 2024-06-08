import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool fieldTap = false.obs;
    RxBool isLoading = false.obs;
  RxString selectedLanguage = 'en'.obs; // Default source language is English
  RxString targetLanguage = 'es'.obs; // Default target language is Spanish

  void setFieldTap(bool value) {
    fieldTap.value = value;
  }

  String get selectedLanguageCode => selectedLanguage.value;

  String get targetLanguageCode => targetLanguage.value;

  void setSelectedLanguage(String language) {
    selectedLanguage.value = language;
  }

  void setTargetLanguage(String language) {
    targetLanguage.value = language;
  }
}
