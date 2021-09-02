import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';
import '../auth_controller.dart';

Widget loginRegisterBtn(
    {required VoidCallback ontap,
    required String label,
    required bool isLogin}) {
  final AuthController _authController = Get.find();

  return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.all(height(8)),
        child: Container(
          height: height(45),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size(20),
                        color: lowBlack),
                  ),
                ),
                AnimatedOpacity(
                  opacity: isLogin ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  // visible: isLogin,
                  child: Container(
                    height: height(5),
                    width: width(30),
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
  );
}
