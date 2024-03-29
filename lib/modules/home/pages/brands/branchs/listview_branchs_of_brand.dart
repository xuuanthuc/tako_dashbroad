import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/modules/home/pages/brands/branchs/edit_or_addNew_branch.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../../../../app_pages.dart';
import '../../../home_controller.dart';
import 'menu/edit_or_addNew_menu.dart';

class ListBranchsOfBrandPage extends StatelessWidget {
  ListBranchsOfBrandPage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: white,
        appBar: appbarDesignSimple(
            title:
                '${_homeController.labelBrand.value} (${_homeController.listBranchs.length})',
            addNewItem: () => Get.to(() => EditOrAddBranch(
                  brandId: _homeController.listBranchs.value[0].brandId ?? "",
                  branchID: "",
                ))),
        body: _homeController.isLoading.value == true
            ? LazyLoad()
            : ListView.builder(
                itemBuilder: (context, index) {
                  return branchItemManagement(
                    ontap: () async {
                      var isSuccess = await _homeController.getMenuOfBranch(
                        brand:
                            _homeController.listBranchs.value[index].brandId ??
                                "",
                        idBranch:
                            _homeController.listBranchs.value[index].branchId ??
                                "",
                        branchName: _homeController
                                .listBranchs.value[index].branchName ??
                            "",
                        branchAddress:
                            _homeController.listBranchs.value[index].address ??
                                "",
                        branchDistrict:
                            _homeController.listBranchs.value[index].district ??
                                "",
                      );
                      if (isSuccess) {
                        Get.toNamed(Routes.MENU_ITEM);
                      } else {
                        Get.to(()=> EditOrAddMenu(
                          brandId: _homeController.listBranchs.value[index].brandId ??
                              "",
                          branchID: _homeController.listBranchs.value[index].branchId ??
                              "",
                          menuID: "",
                        ));
                      }
                    },
                    onTapEdit: () {
                      Get.to(
                        () => EditOrAddBranch(
                          brandId: _homeController
                                  .listBranchs.value[index].brandId ??
                              "",
                          branchID: _homeController
                                  .listBranchs.value[index].branchId ??
                              "",
                          brachItem: _homeController
                              .listBranchs.value[index],
                        ),
                      );
                    },
                    label: _homeController.listBranchs.value[index].branchName,
                    address: _homeController.listBranchs.value[index].address,
                    district: _homeController.listBranchs.value[index].district,
                    image: _homeController.thumbnailBrand.value,
                  );
                },
                itemCount: _homeController.listBranchs.length,
              ),
      ),
    );
  }
}

Padding branchItemManagement({
  String? label,
  String? image,
  String? address,
  String? district,
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
            height: 70,
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
                  label!,
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
                  '$address, $district',
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
                  onPressed: onTapEdit, color: white, icon: Icon(Icons.edit))),
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
