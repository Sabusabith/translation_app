import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/color.dart';
import '../../controller/camera_controller.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CameraScreenController controller = Get.put(CameraScreenController());

    return Scaffold(
     appBar: AppBar( leading: GestureDetector(onTap: () {
       Get.back();
     },child: Icon(Icons.arrow_back_ios,color: Colors.grey.shade200,)),backgroundColor: kbgcolor2,
        centerTitle: true, title: Text(
          "TransWay",
          style: GoogleFonts.dmMono(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),),
      body: GetBuilder<CameraScreenController>(
        builder: (controller) {
          return Stack(fit: StackFit.expand,
            children: [
              FutureBuilder<void>(
                future: controller.initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(controller.cameraController);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: Center(
                  child: FloatingActionButton(
                    backgroundColor: kbgcolor2,
                    onPressed: () async {
                      try {
                        await controller.initializeControllerFuture;

                        final image = await controller.cameraController.takePicture();

                        final recognizedText = await controller.recognizeText(image);

                        Navigator.pop(context, recognizedText);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(Icons.camera_alt,color: Colors.white,),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
