import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translate_do/common/color.dart';

class Result extends StatelessWidget {
  Result({super.key, required this.result});
  String result;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey.shade200,
            )),
        backgroundColor: kbgcolor2,
        centerTitle: true,
        title: Text(
          "Translate",
          style: GoogleFonts.dmMono(
              color: Colors.grey.shade400, fontWeight: FontWeight.bold),
        ),
        actions: [
          SizedBox(
            width: 15,
          ),
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
      backgroundColor: kbgcolor2,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: TextEditingController(text: result),
              decoration: InputDecoration(
                
                border: InputBorder.none,
              ),
              style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  height: 2),
            ),
          ),
        ),
      ),
    );
  }
}
