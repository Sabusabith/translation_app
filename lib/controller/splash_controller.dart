import 'package:get/get.dart';
import 'package:translate_do/screens/home/home.dart';

class SplashController extends GetxController{
   



@override
  void onInit() {
    // TODO: implement onInit
    
    timer();
  }
  timer(){
    Future.delayed(Duration(seconds: 1)).then((value) => Get.to(Home()));
  }

}