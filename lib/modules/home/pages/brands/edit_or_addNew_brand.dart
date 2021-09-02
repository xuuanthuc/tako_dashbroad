import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/util/common/screen_util.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';

import '../../home_controller.dart';

class EditOrAddBrand extends StatefulWidget {
  EditOrAddBrand({Key? key, this.brandId}) : super(key: key);
  String? brandId;

  @override
  _EditOrAddBrandState createState() => _EditOrAddBrandState();
}

class _EditOrAddBrandState extends State<EditOrAddBrand> {
  final HomeController _homeController = Get.find();
  final TextEditingController brandNameTextController = TextEditingController();
  final TextEditingController brandThumbnailTextController =
      TextEditingController();

  void editOrAddNew() {
    if (widget.brandId != "") {
      _homeController.setNewBrand(
        brandName: brandNameTextController.text,
        thumbnail: brandThumbnailTextController.text,
        id: widget.brandId ?? "",
      );
    } else {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      _homeController.setNewBrand(
        brandName: brandNameTextController.text,
        thumbnail: brandThumbnailTextController.text,
        id: getRandomString(24),
      );
    }
    Get.back();

  }

  void deleteBrand() {
    if (widget.brandId != "") {
      _homeController.deleteBrand(id: widget.brandId ?? "");
      Get.back();
    } else {
      Get.defaultDialog(
        title: 'Cannot delete empty item!',
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.brandId != "") {
      _homeController.getInfoBrand(brand: widget.brandId ?? "");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    brandNameTextController.dispose();
    brandThumbnailTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.brandId != "") {
        brandNameTextController.text = _homeController.labelBrand.value;
        brandThumbnailTextController.text =
            _homeController.thumbnailBrand.value;
      }
      return _homeController.isLoading.value == true
          ? LazyLoad()
          : Scaffold(
              backgroundColor: white,
              appBar: appbarDesignSimple(
                title: widget.brandId != ""
                    ? _homeController.labelBrand.value
                    : 'Add New Item',
                addNewItem: editOrAddNew,
              ),
              body: Padding(
                padding: EdgeInsets.all(50),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          child: Image.network(widget.brandId != ""
                              ? brandThumbnailTextController.text
                              : 'https://s.meta.com.vn/img/thumb.ashx/Data/image/2021/03/31/anh-trang-29.jpg'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: brandNameTextController,
                          decoration: InputDecoration(
                            hintText: 'Nhập tên cho thương hiệu',
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
                          controller: brandThumbnailTextController,
                          decoration: InputDecoration(
                            hintText: 'Đường dẫn ảnh cho thương hiệu',
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
                              widget.brandId != ""
                                  ? 'EDIT BRAND'
                                  : 'ADD NEW BRAND',
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
