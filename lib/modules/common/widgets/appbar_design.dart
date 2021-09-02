import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/constants/app_image.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';
import 'package:get/get.dart';

AppBar AppBarDesign({required VoidCallback ontap}) {
  return AppBar(
    title: Container(height: height(40),child: Image.asset(AppFileName.logoOrange, fit: BoxFit.fill,)),
    automaticallyImplyLeading: false,
    centerTitle: false,
    backgroundColor: white,
    elevation: 0,
    // actions: [
    //   IconButton(onPressed: ontap, icon: Icon(Icons.menu, color: lowBlack,))
    // ],
  );
}

AppBar appbarDesignSimple({required String title,required VoidCallback addNewItem}) {
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
    title: Text(
      title,
      style: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size(20),
            color: lowBlack,
          )),
    ),
    actions: [
      IconButton(onPressed: addNewItem, icon: Icon(Icons.add,color: lowBlack,)),
    ],
  );
}
