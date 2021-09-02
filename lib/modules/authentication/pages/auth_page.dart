import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/authentication/widgets/form_login_widget.dart';
import 'package:tako_dashbroad/modules/authentication/widgets/form_register_widget.dart';
import 'package:tako_dashbroad/modules/authentication/widgets/login_register_button_custom.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/custom_button_design.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/constants/app_image.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../auth_controller.dart';


class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController _authController = Get.find();
  final _formUser = GlobalKey<FormState>();
  final _formPass = GlobalKey<FormState>();

  bool isLoading = false;

  void tapLogin() {
    _authController.isLogin.value = true;
    print('login');
  }

  void tapRegister() {
    _authController.isLogin.value = false;
    print('register');
  }

  Future<void> submitAuthentication() async {
    if (!_authController.formPass.currentState!.validate() &&
        !_authController.formUser.currentState!.validate()) {
    } else if (!_authController.formPass.currentState!.validate() ||
        !_authController.formUser.currentState!.validate()) {
    }  else {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1));
      // _authController.sumbit();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
      ),
      backgroundColor: white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height(30)),
                Row(
                  //Logo app
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height(54),
                      width: width(187),
                      child: Image.asset(
                        AppFileName.logoOrange,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(57)),
                Row(
                  //Hang chon loai dang nhap dang ky
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => loginRegisterBtn(
                          isLogin: _authController.isLogin.value,
                          label: 'Đăng nhập',
                          ontap: () => tapLogin()),
                    ),
                    Obx(
                      () => loginRegisterBtn(
                          isLogin: !_authController.isLogin.value,
                          label: 'Đăng ký',
                          ontap: () => tapRegister()),
                    )
                  ],
                ),
                SizedBox(height: height(15)),
                Stack(
                  children: [
                    Obx(
                      () => AnimatedOpacity(
                        child: Visibility(
                            visible: _authController.isLogin.value,
                            child: FormLoginWidget()),
                        opacity: _authController.isLogin.value ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                      ),
                    ),
                    Obx(
                      () => AnimatedOpacity(
                        child: Visibility(
                            visible: !_authController.isLogin.value,
                            child: FormRegisterWidget()),
                        opacity: !_authController.isLogin.value ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(40)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(65), vertical: height(30)),
                  child: Obx(
                    () => CustumButtonDesign(
                        ontap: () {
                          FocusScope.of(context).unfocus();
                          submitAuthentication();
                        },
                        label: _authController.isLogin == true
                            ? 'Đăng nhập'
                            : 'Đăng ký'),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLoading,
            child: LazyLoad(),
          )
        ],
      ),
    );
  }
}
