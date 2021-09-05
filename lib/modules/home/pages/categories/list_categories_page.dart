import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/app_pages.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/modules/home/pages/categories/edit_or_add_new_category_menu.dart';
import 'package:tako_dashbroad/util/constants/app_image.dart';
import 'package:tako_dashbroad/util/constants/locale_keys.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../home_controller.dart';

class ListCategoriesScreen extends StatelessWidget {
  ListCategoriesScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  void getMenu({required String categoryKey}) async {
    var success =
        await _homeController.getCategoryMenu(categoryKey: categoryKey);
    if (success) {
      Get.toNamed(Routes.CATEGORY_MENU);
    } else {
      Get.to(()=> EditOrAddCategoryMenu(categoryKey: categoryKey, menuID: "",));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarDesignSimple(title: 'Category', addNewItem: () {}),
      body: ListView(
        children: [
          CategoryItemDesign(
              title: 'Gần Bạn',
              image: AppFileName.effect_1,
              ontap: () => getMenu(categoryKey: LocaleKeys.nearYou)),
          CategoryItemDesign(
              title: 'Cơm Xuất',
              image: AppFileName.effect_2,
              ontap: () => getMenu(categoryKey: LocaleKeys.rice)),
          CategoryItemDesign(
              title: 'Bún/ Phở',
              image: AppFileName.effect_3,
              ontap: () => getMenu(categoryKey: LocaleKeys.noodle)),
          CategoryItemDesign(
              title: 'Gà Rán',
              image: AppFileName.effect_4,
              ontap: () => getMenu(categoryKey: LocaleKeys.chicken)),
          CategoryItemDesign(
              title: 'Ăn Vặt',
              image: AppFileName.effect_5,
              ontap: () => getMenu(categoryKey: LocaleKeys.snack)),
          CategoryItemDesign(
              title: 'Đồ Uống',
              image: AppFileName.effect_6,
              ontap: () => getMenu(categoryKey: LocaleKeys.drink)),
          CategoryItemDesign(
              title: 'Bánh Mì',
              image: AppFileName.effect_7,
              ontap: () => getMenu(categoryKey: LocaleKeys.bread)),
          CategoryItemDesign(
              title: 'Healthy',
              image: AppFileName.effect_8,
              ontap: () => getMenu(categoryKey: LocaleKeys.healthy)),
        ],
      ),
    );
  }

  Widget CategoryItemDesign(
      {required String title,
      required String image,
      required VoidCallback ontap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        height: 70,
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
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              height: 30,
              width: 30,
              child: Image.asset(image),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: lowBlack,
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                    onPressed: ontap,
                    color: white,
                    icon: Icon(Icons.arrow_forward))),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
