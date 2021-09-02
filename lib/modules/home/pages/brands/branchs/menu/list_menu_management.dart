import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/modules/home/pages/brands/branchs/menu/edit_or_addNew_menu.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../../../home_controller.dart';

class MenuManagement extends StatelessWidget {
  MenuManagement({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      backgroundColor: white,
      appBar: appbarDesignSimple(
          title:
              "${_homeController.listMenu.value[0].branchName} (${_homeController.listMenu.length})",
          addNewItem: () {
            Get.to(
                  () => EditOrAddMenu(
                menuID: "",
                brandId: _homeController.listMenu.value[0].brandId ?? "",
                branchID: _homeController.listMenu.value[0].branchId ?? "",
              ),
            );
          }),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return menuItemManagement(
            ontap: () {
              Get.to(
                () => EditOrAddMenu(
                  menuID: _homeController.listMenu.value[index].menuId,
                  brandId: _homeController.listMenu.value[index].brandId ?? "",
                  branchID: _homeController.listMenu.value[index].branchId ?? "",
                  menuItem: _homeController.listMenu.value[index],
                ),
              );
            },
            itemName: "${_homeController.listMenu.value[index].item}",
            itemImage: "${_homeController.listMenu.value[index].image}",
            itemPrice: "${_homeController.listMenu.value[index].price}",
            itemType: "${_homeController.listMenu.value[index].type}",
          );
        },
        itemCount: _homeController.listMenu.length,
      ),
    ));
  }
}

Padding menuItemManagement(
    {required String itemImage,
    required String itemName,
    required String itemPrice,
    required String itemType,
    required VoidCallback ontap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Container(
      decoration: BoxDecoration(
        color: greySmall,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 88,
      child: Row(
        children: [
          Container(
            height: 88,
            width: 88,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              child: Image.network(
                itemImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Type: ${itemType} ---- Name: ${itemName}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: lowBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Price: ${itemPrice}",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: lowBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                color: lowBlack,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                  onPressed: ontap, color: white, icon: Icon(Icons.edit))),
          SizedBox(width: 16),
        ],
      ),
    ),
  );
}
