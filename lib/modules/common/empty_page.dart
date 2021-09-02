import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/constants/app_image.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

class EmptyPage extends StatelessWidget {
  EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarDesign(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: height(100),
            ),
            Container(
              height: height(200),
              width: height(200),
              child: Image.asset(
                AppFileName.empty,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: height(30),
            ),
            Text(
              "Danh sách hiện đang trống!\nBạn hãy quay lại sau nhé!",
              textAlign: TextAlign.center,
              style: GoogleFonts.bungee(
                textStyle: TextStyle(
                  height: 1.8,
                  fontWeight: FontWeight.w700,
                  fontSize: size(20),
                  color: orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar appbarDesign() {
  return AppBar(
    backgroundColor: white,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: lowBlack,
        )),
  );
}
