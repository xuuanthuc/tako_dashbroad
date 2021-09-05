import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../home_controller.dart';
import 'edit_or_add_new_category_menu.dart';

class MenuListCategory extends StatelessWidget {
  MenuListCategory({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      backgroundColor: white,
      appBar: appbarDesignSimple(title: 'Category ${_homeController.listCategoryMenu[0].categoryType}', addNewItem: ()=>Get.to(()=> EditOrAddCategoryMenu(categoryKey: _homeController.listCategoryMenu[0].categoryType, menuID: "",)),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        var item = _homeController.listCategoryMenu[index];
        return menuItem(
          itemName: item.item,
          image: item.image,
          price: item.price,
          address: item.address,
          description: item.description,
          onTapEdit: (){
            Get.to(()=> EditOrAddCategoryMenu(categoryKey: item.categoryType, menuID: item.id,categoryMenu: item, ));
          }
        );
      },
      itemCount: _homeController.listCategoryMenu.length,),
    ));
  }

  Padding menuItem({
    String? itemName,
    String? image,
    String? address,
    String? description,
    String? price,
    VoidCallback? ontap,
    VoidCallback? onTapEdit,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image!,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$itemName - $description',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: lowBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Price: $price, Address: $address',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: lowBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                    onPressed: onTapEdit,
                    color: white,
                    icon: Icon(Icons.edit))),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}