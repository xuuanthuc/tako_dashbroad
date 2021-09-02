import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/modules/home/home_controller.dart';
import 'package:tako_dashbroad/modules/home/pages/widgets/category_selection_widget.dart';
import 'package:tako_dashbroad/modules/home/pages/widgets/form_test_import_data.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';
import '../../../app_pages.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  DateTime? currentBackPressTime;
  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Nhấn BACK lần nữa để thoát!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: orange,
          textColor: white,
          fontSize: 13.0
      );
      return Future.value(false);
    }
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBarDesign(ontap: () {
          Get.toNamed(Routes.SETTING);
        }),
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height(65)),
                Container(
                  height: 300,
                  color: Colors.red,
                  child: TextButton(
                    onPressed: ()=> Get.toNamed(Routes.BANNER_MANAGEMENT),
                    child: Text("Banner "),
                  ),
                ),
                // CategorySelectionDesgin(),
                TextButton.icon(
                  onPressed: () {
                    Get.toNamed(Routes.LISTBRANDS);
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: lowBlack,
                    size: size(18),
                  ),
                  label: Text(
                    "Xem tất cả nhan hieu",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: size(14),
                            fontWeight: FontWeight.w700,
                            color: lowBlack)),
                  ),
                ),
                // Container(
                //   height: 300,
                //   color: Colors.red,
                //   child: TextButton(
                //     onPressed: ()=> Get.to(()=>FormImport()),
                //     child: Text("New branchs"),
                //   ),
                // ),
                // Container(
                //   height: 300,
                //   color: Colors.red,
                // ),
                // Container(
                //   height: 300,
                //   color: Colors.red,
                // ),
              ],
            ),
          ),
        ));
  }



}
