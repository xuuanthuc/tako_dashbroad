import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tako_dashbroad/modules/authentication/auth_controller.dart';
import 'package:tako_dashbroad/modules/home/home_controller.dart';
import 'package:tako_dashbroad/modules/settings/widgets/appbar_setting_page.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/constants/app_image.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';


class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.find();

  void logOut() {
    // _authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: white,
          appBar: buildAppBar(),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(height(30)),
            child: Container(
                height: height(30), child: Image.asset(AppFileName.logoOrange)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardNameCustom(),
              Divider(),
              SizedBox(
                height: height(10),
              ),
              ListSettingOption(
                label: 'Yêu thích',
                onPressed: () {},
              ),
              SizedBox(
                height: height(10),
              ),
              ListSettingOption(
                label: 'Lịch sử',
                onPressed: () {},
              ),
              SizedBox(
                height: height(10),
              ),
              ListSettingOption(
                label: 'Trung tâm trợ giúp',
                onPressed: () {},
              ),
              SizedBox(
                height: height(10),
              ),
              ListSettingOption(
                label: 'Đăng xuất',
                onPressed: () => logOut(),
              ),
            ],
          ),
        ));
  }

  Widget ListSettingOption(
      {required String label, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(8)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: size(16),
              color: lowBlack,
            ),
          ),
        ),
      ),
    );
  }

  Widget cardNameCustom() {
    return Padding(
      padding: EdgeInsets.all(width(16)),
      child: Row(
        children: [
          Container(
            height: height(88),
            width: height(88),
            child: Image.asset(
              AppFileName.avatar,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: width(24),
          ),
          Expanded(
            child: Text(
              _authController.user.value.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: size(20),
                  color: lowBlack,
                ),
              ),
            ),
          ),
          Container(
            width: width(50),
            child: IconButton(
              onPressed: () {},
              iconSize: size(50),
              icon: Icon(
                Icons.arrow_right,
              ),
              color: orange,
            ),
          )
        ],
      ),
    );
  }
}
