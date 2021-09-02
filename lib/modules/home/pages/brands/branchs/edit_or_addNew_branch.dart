import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/models/brand_model.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../../home_controller.dart';

class EditOrAddBranch extends StatefulWidget {
  EditOrAddBranch({Key? key, this.brandId, this.branchID, this.brachItem})
      : super(key: key);
  String? brandId;
  String? branchID;
  Branch? brachItem;

  @override
  _EditOrAddBrandState createState() => _EditOrAddBrandState();
}

class _EditOrAddBrandState extends State<EditOrAddBranch> {
  final HomeController _homeController = Get.find();
  final TextEditingController branchNameTextController =
      TextEditingController();
  final TextEditingController branchAddressTextController =
      TextEditingController();
  final TextEditingController branchDistrictTextController =
      TextEditingController();

  void editOrAddNew() {
    if (widget.branchID != "") {
      _homeController.setNewBranch(
        branchName: branchNameTextController.text,
        branchId: widget.branchID ?? "",
        brandId: widget.brandId ?? "",
        branchAddress: branchAddressTextController.text,
        district: branchDistrictTextController.text,
      );
    } else {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      _homeController.setNewBranch(
        branchName: branchNameTextController.text,
        branchId: getRandomString(24),
        brandId: widget.brandId ?? "",
        branchAddress: branchAddressTextController.text,
        district: branchDistrictTextController.text,
      );
    }
    Get.back();
  }

  void deleteBrand() {
    if (widget.branchID != "") {
      _homeController.deleteBranch(
          branchId: widget.branchID ?? "", brandId: widget.brandId ?? "");
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
    branchNameTextController.dispose();
    branchAddressTextController.dispose();
    branchDistrictTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.branchID != "") {
        branchNameTextController.text = widget.brachItem!.branchName ?? "";
        branchAddressTextController.text = widget.brachItem!.address ?? "";
        branchDistrictTextController.text = widget.brachItem!.district ?? "";
      }
      return _homeController.isLoading.value == true
          ? LazyLoad()
          : Scaffold(
              backgroundColor: white,
              appBar: appbarDesignSimple(
                title: widget.branchID != ""
                    ? 'Update branch'
                    : 'Thêm chi nhánh mới',
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
                          controller: branchNameTextController,
                          decoration: InputDecoration(
                            hintText: 'Nhập tên cho cơ sở',
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
                          controller: branchAddressTextController,
                          decoration: InputDecoration(
                            hintText: 'Đường',
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
                          controller: branchDistrictTextController,
                          decoration: InputDecoration(
                            hintText: 'Quận/ Huyện',
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
                              widget.branchID != ""
                                  ? 'EDIT BRANCH'
                                  : 'ADD NEW BRANCH',
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
