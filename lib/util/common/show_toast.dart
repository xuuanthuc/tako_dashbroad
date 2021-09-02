import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';
  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: lowOrange,
        textColor: Colors.black,
        fontSize: 16.0,
    );
  }
