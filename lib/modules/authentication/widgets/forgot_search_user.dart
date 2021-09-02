import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/custom_button_design.dart';
import 'package:tako_dashbroad/modules/common/widgets/input_decoration_design.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/constants/app_image.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';


import '../auth_controller.dart';
import 'package:get/get.dart';

class ForgotSearchUserWidget extends StatefulWidget {
  ForgotSearchUserWidget({Key? key}) : super(key: key);

  @override
  _ForgotSearchUserWidgetState createState() => _ForgotSearchUserWidgetState();
}

class _ForgotSearchUserWidgetState extends State<ForgotSearchUserWidget> {
  final AuthController _authController = Get.find();

  TextEditingController newPassController = TextEditingController();

  bool isLoading = false;

  Future<void> submitAuth() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    // _authController.resetPassword(newPass: newPassController.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: width(54),
                    width: width(187),
                    child: Image.asset(AppFileName.logoOrange),
                  ),
                ],
              ),
              SizedBox(height: height(60)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quên mật khẩu?',
                    style: GoogleFonts.bungee(
                      textStyle: TextStyle(
                        height: 1.4,
                        fontSize: size(20),
                        color: lowBlack,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(30)),
                child: Text(
                  'Nhập thông tin số điện thoại hoặc email xác thực TAKO của bạn và nhập mật khẩu mới',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      height: 1.4,
                      fontSize: size(16),
                      color: lowBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height(50)),
              labelTextField('Số điện thoại hoặc email'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(30)),
                child: TextField(
                  onChanged: (text) {
                    // do something with text
                    _authController.username.value = text;
                  },
                  textInputAction: TextInputAction.next,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size(16),
                          color: lowBlack)),
                  decoration: decorTextField(
                      'Nhập số điện thoại hoặc email đã đăng ký'),
                ),
              ),
              SizedBox(height: height(20)),
              labelTextField('Mật khẩu'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(30)),
                child: TextField(
                  controller: newPassController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size(16),
                          color: lowBlack)),
                  decoration: decorTextField('Nhập mật khẩu mới'),
                ),
              ),
              SizedBox(height: height(40)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width(65), vertical: height(30)),
                child: CustumButtonDesign(
                    ontap: () {
                      FocusScope.of(context).unfocus();
                      submitAuth();
                    },
                    label: 'Xác nhận'),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isLoading,
          child: LazyLoad(),
        )
      ],
    );
  }

  Widget labelTextField(String label) => Padding(
        padding: EdgeInsets.symmetric(horizontal: width(30)),
        child: Text(
          label,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: size(16),
                  color: lowBlack)),
        ),
      );
}
