import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../common/audioFn.dart';

class MicController extends GetxController{

RxBool tapped = false.obs;

RxBool isPlaying = false.obs; 
handleTap(){
  tapped.value = !tapped.value;
 tapped.value ? playStopSound() : playSound(); 
}
}