import 'package:get/get.dart';

class HomeController extends GetxController{
RxBool fieldTap = false.obs;

 void setFieldTap(bool value) {
    fieldTap.value = value;
  }
}