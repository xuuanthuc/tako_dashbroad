import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/modules/home/home_controller.dart';
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
          child: ListView(
            children: [
              SizedBox(height: height(65)),
              Text('So luong brand: ${_homeController.listBrands.length}'),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(4, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: ()=> Get.toNamed(Routes.BANNER_MANAGEMENT),
                    child: Text("Banner"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(4, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: ()=> Get.toNamed(Routes.LISTBRANDS),
                    child: Text("branchs"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(4, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: ()=> Get.toNamed(Routes.CATEGORY),
                    child: Text("Category"),
                  ),
                ),
              ),
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
        ));
  }



}
