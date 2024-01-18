import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translate_do/common/color.dart';
import 'package:translate_do/controller/home_controller.dart';
import 'package:translate_do/controller/mic_controller.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../common/audioFn.dart';

class Home extends StatelessWidget {
  Home({super.key});
  MicController micController = Get.put(MicController());
  HomeController homeController = Get.put(HomeController());
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kbgcolor2,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: kbgcolor2,
        centerTitle: true,
        title: Text(
          "Translate",
          style: GoogleFonts.dmMono(
              color: Colors.grey.shade400, fontWeight: FontWeight.bold),
        ),
        actions:  [
               Obx(()=>
              homeController.fieldTap.value?GestureDetector(onTap: (){
textController.clear();

              },
                child: Icon(
                CupertinoIcons.clear,
                color: Colors.white,
                size: 25,
                         ),
              ):SizedBox(),
           ),
           SizedBox(width: 15,),
          Icon(
            CupertinoIcons.camera_viewfinder,
            color: Colors.white,
            size: 30,
          ),
      
          SizedBox(
            width: 15,
          )
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
                    child: TextField(controller: textController,onTap: (){
                       homeController.setFieldTap(true);
                    },
                      style: GoogleFonts.dmSans(color:Colors.white,fontSize:18,fontWeight:FontWeight.bold,letterSpacing:1,height:2),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color:Colors.grey.shade600,fontSize: 18,fontWeight:FontWeight.bold,letterSpacing: 1),
                          hintText: "Enter text here"),
                      maxLines: 1000,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 280,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: kbgcolor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          micController.handleTap();
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
                                    // Replace this child with your own
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: kbuttoncolor),
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
                                      color: kbuttoncolor),
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
                            width: 25,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    backgroundColor:
                                        MaterialStatePropertyAll(kbutton2)),
                                onPressed: () {
                                                          FocusScope.of(context).unfocus();

                                },
                                child: Text(
                                  "English",
                                  style: GoogleFonts.dmMono(
                                      color: Colors.grey.shade300),
                                )),
                          ),
                          Image.asset(
                            "assets/images/switch.png",
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                        Colors.black.withOpacity(.2)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    backgroundColor:
                                        MaterialStatePropertyAll(kbutton2)),
                                onPressed: () {},
                                child: Text(
                                  "English",
                                  style: GoogleFonts.dmMono(
                                      color: Colors.grey.shade300),
                                )),
                          ),
                          SizedBox(
                            width: 25,
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
          )),
    );
  }
}
