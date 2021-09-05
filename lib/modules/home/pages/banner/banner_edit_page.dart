import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tako_dashbroad/modules/common/lazy_load_widget.dart';
import 'package:tako_dashbroad/modules/common/widgets/appbar_design.dart';
import 'package:tako_dashbroad/util/theme/app_colors.dart';
import '../../home_controller.dart';

class BannerManagement extends StatelessWidget {
  BannerManagement({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());
  final TextEditingController banner1TextController = TextEditingController();
  final TextEditingController banner2TextController = TextEditingController();
  final TextEditingController banner3TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarDesignSimple(title: 'Banner Management',addNewItem: (){}),
      body: Container(
        child: SingleChildScrollView(
          child: Obx(() {
            banner1TextController.text = _homeController.pathBanner1.value;
            banner2TextController.text = _homeController.pathBanner2.value;
            banner3TextController.text = _homeController.pathBanner3.value;
            return _homeController.isLoading.value == true
                ? LazyLoad()
                : Column(
              children: [
                bannerItemDesign(
                  urlImage: _homeController.pathBanner1.value,
                  controller: banner1TextController
                ),
                bannerItemDesign(
                  urlImage: _homeController.pathBanner2.value,
                    controller: banner2TextController
                ),
                bannerItemDesign(
                  urlImage: _homeController.pathBanner3.value,
                    controller: banner3TextController
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget bannerItemDesign({required String urlImage, required TextEditingController controller}) {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              width: 200,
              child: _homeController.isLoading.value == true
                  ? LazyLoad()
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.network(
                        urlImage,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
            ),
            SizedBox(
              width: 30,
            ),
            // Expanded(child: Text('${urlImage}', maxLines: 5,)),
            Expanded(
                child: TextField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: lowBlack),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: orange),
                ),
              ),
            )),
            SizedBox(
              width: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: orange),
                child: IconButton(
                    onPressed: () => _homeController.updateBanner(
                        urlBanner1: banner1TextController.text,
                        urlBanner2: banner2TextController.text,
                        urlBanner3: banner3TextController.text),
                    iconSize: 30,
                    color: white,
                    icon: Icon(
                      Icons.edit,
                      // color: white,
                    ))),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
