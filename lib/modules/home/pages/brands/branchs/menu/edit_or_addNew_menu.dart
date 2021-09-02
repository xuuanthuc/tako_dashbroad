import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/models/brand_model.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../../../home_controller.dart';

class EditOrAddMenu extends StatefulWidget {
  EditOrAddMenu({Key? key, this.brandId, this.branchID, this.menuItem, this.menuID})
      : super(key: key);
  String? brandId;
  String? branchID;
  String? menuID;
  MenuItem? menuItem;

  @override
  _EditOrAddBrandState createState() => _EditOrAddBrandState();
}

class _EditOrAddBrandState extends State<EditOrAddMenu> {
  final HomeController _homeController = Get.find();
  final TextEditingController itemNameText = TextEditingController();
  final TextEditingController imageUrlText = TextEditingController();
  final TextEditingController priceItemText = TextEditingController();
  final TextEditingController typeText = TextEditingController();

  void editOrAddNew() {
    if (widget.menuID != "") {
      _homeController.setNewMenuOfBranch(
        itemName: itemNameText.text,
        branchId: widget.branchID ?? "",
        brandId: widget.brandId ?? "",
        price: priceItemText.text,
        type: typeText.text,
        imageUrl: imageUrlText.text,
        menuId: widget.menuID ?? "",
      );
    } else {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      _homeController.setNewMenuOfBranch(
        itemName: itemNameText.text,
        branchId: widget.branchID ?? "",
        brandId: widget.brandId ?? "",
        price: priceItemText.text,
        type: typeText.text,
        imageUrl: imageUrlText.text,
        menuId: getRandomString(24),
      );
    }
    Get.back();
  }

  void deleteBrand() {
    if (widget.menuID != "") {
      _homeController.deleteMenu(
          branchId: widget.branchID ?? "", brandId: widget.brandId ?? "", menuId: widget.menuID ?? "");
      Get.back();
    } else {
      Get.defaultDialog(
        title: 'Cannot delete empty item!',
      );
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if (widget.branchID != "") {
  //     _homeController.getInfoBranch(
  //         brandId: widget.brandId ?? "",
  //         branchId: widget.branchID ?? "",
  //     );
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    itemNameText.dispose();
    imageUrlText.dispose();
    priceItemText.dispose();
    typeText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.menuID != "") {
        itemNameText.text = widget.menuItem!.item ?? "";
        imageUrlText.text = widget.menuItem!.image ?? "";
        priceItemText.text = widget.menuItem!.price ?? "";
        typeText.text = widget.menuItem!.type ?? "";
      }
      return _homeController.isLoading.value == true
          ? LazyLoad()
          : Scaffold(
              backgroundColor: white,
              appBar: appbarDesignSimple(
                title: widget.menuID != ""
                    ? 'Update menu'
                    : 'Thêm menu mới',
                addNewItem: editOrAddNew,
              ),
              body: Padding(
                padding: EdgeInsets.all(50),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: itemNameText,
                          decoration: InputDecoration(
                            hintText: 'Tên đồ ăn, đồ uống....',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lowBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: priceItemText,
                          decoration: InputDecoration(
                            hintText: 'Giá tiền',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lowBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: imageUrlText,
                          decoration: InputDecoration(
                            hintText: 'Đường dẫn ảnh',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lowBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: typeText,
                          decoration: InputDecoration(
                            hintText: 'Loại đồ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lowBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color?>(orange),
                          ),
                          onPressed: editOrAddNew,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text(
                              widget.menuID != ""
                                  ? 'EDIT MENU'
                                  : 'ADD NEW TO MENU',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: size(20),
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        onPressed: deleteBrand,
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                      ),
                    )
                  ],
                ),
              ),
            );
    });
  }
}
