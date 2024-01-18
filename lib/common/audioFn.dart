  import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translate_do/controller/mic_controller.dart';

  MicController micController = Get.put(MicController());
  
  FutureBuilder<void> playSound() {
    final audioplayer = AudioPlayer();
    return FutureBuilder<void>(
      future: audioplayer.play(AssetSource('audio/tone.wav')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Sound played successfully
      
          print('Sound played successfully');
        } else if (snapshot.hasError) {
          // Error playing sound
          print('Error playing sound');
        }
        // Return an empty container since the function returns void
        return Container();
      },
    );
  }

   FutureBuilder<void> playStopSound() {
        final audioplayer = AudioPlayer();

    return FutureBuilder<void>(
      future: audioplayer.play(AssetSource('audio/start.wav')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Sound played successfully
  
          print('Stop sound played successfully');
        } else if (snapshot.hasError) {
          // Error playing sound
          print('Error playing stop sound');
        }
        // Return an empty container since the function returns void
        return Container();
      },
    );
  }