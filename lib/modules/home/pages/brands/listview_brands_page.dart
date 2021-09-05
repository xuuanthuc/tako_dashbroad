import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/modules/home/pages/brands/branchs/edit_or_addNew_branch.dart';
import 'package:tako_dashbroad/modules/home/pages/brands/edit_or_addNew_brand.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../../../app_pages.dart';
import '../../home_controller.dart';

class ListBrandsPage extends StatelessWidget {
  ListBrandsPage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      backgroundColor: white,
      appBar: appbarDesignSimple(title: 'Brand Management', addNewItem: () => Get.to(()=>EditOrAddBrand(brandId: "",))),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return brandItemManagement(
            ontap: () async {
              _homeController.getInfoBrand(
                  brand: _homeController.listBrands.value[index].brandId ?? "");
              var isSuccess = await _homeController.getBranchOfBrand(
                brand: _homeController.listBrands.value[index].brandId ?? "",
              );
              if (isSuccess) {
                Get.toNamed(Routes.BRANCHS_OF_BRAND);
              } else {
                Get.to(()=> EditOrAddBranch(brandId: _homeController.listBrands.value[index].brandId ?? "", branchID: "",));
              }
            },
            onTapEdit: (){
              Get.to(()=> EditOrAddBrand(brandId: _homeController.listBrands.value[index].brandId,));
            },
            label: _homeController.listBrands.value[index].brandName ?? "",
            image: _homeController.listBrands.value[index].thumbnail ?? "",
          );
        },
        itemCount: _homeController.listBrands.length,
      ),
    ));
  }
}

Padding brandItemManagement({
  required String label,
  required String image,
  required VoidCallback ontap,
  required VoidCallback onTapEdit,
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
      height: 100,
      child: Row(
        children: [
          Container(
            width: 150,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                )),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: GoogleFonts.bungee(
                textStyle: TextStyle(fontSize: 16, color: lowBlack),
              ),
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
            width: 15,
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
