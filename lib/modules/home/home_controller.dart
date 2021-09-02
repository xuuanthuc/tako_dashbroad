// import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:tako_dashbroad/models/brand_model.dart';
import 'package:tako_dashbroad/util/common/logger.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  // final database = FirebaseDatabase.instance.reference();
  RxString pathBanner1 = "https://".obs;
  RxString pathBanner2 = ''.obs;
  RxString pathBanner3 = ''.obs;
  RxBool isLoading = false.obs;
  var listBrands = <Brand>[].obs;
  var listBranchs = <Branch>[].obs;
  var listMenu = <MenuItem>[].obs;
  var branch = Branch().obs;

  RxString labelBrand = ''.obs;
  RxString thumbnailBrand = ''.obs;

  //TODO: Banner
  Future<void> getBanner() async {
    isLoading.value = true;
    var urlBanner1 = 'https://tako-5d6a2-default-rtdb.firebaseio.com/src/images/carousel/banner-1.json';
    var urlBanner2 = 'https://tako-5d6a2-default-rtdb.firebaseio.com/src/images/carousel/banner-2.json';
    var urlBanner3 = 'https://tako-5d6a2-default-rtdb.firebaseio.com/src/images/carousel/banner-3.json';
    final response1 = await Dio().get(urlBanner1);
    final response2 = await Dio().get(urlBanner2);
    final response3 = await Dio().get(urlBanner3);
    if (response1.statusCode == 200){
      pathBanner1.value = response1.data;
    }
    if (response2.statusCode == 200){
      pathBanner2.value = response2.data;
    }
    if (response2.statusCode == 200){
      pathBanner3.value = response3.data;
    }
    isLoading.value = false;
  }

  Future<void> updateBanner({required String urlBanner1, required String urlBanner2, required String urlBanner3}) async{
    isLoading.value = true;
    var urlBanner = 'https://tako-5d6a2-default-rtdb.firebaseio.com/src/images/carousel.json';
    await Dio().put(urlBanner,data: {
      'banner-1': urlBanner1,
      'banner-2': urlBanner2,
      'banner-3': urlBanner3,
    });
    getBanner();
    isLoading.value = false;

  }



  //TODO: Brand: tocotoco, hightland, lotte, royalte, dingtea.....

  void getInfoBrand({required String brand}) async {
    isLoading.value = true;
    var urlBrand = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brand/brandName.json';
    var urlThumbnail = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brand/thumbnail.json';
    var resName = await Dio().get(urlBrand);
    var resThumb = await Dio().get(urlThumbnail);
    if (resName.statusCode == 200){
      labelBrand.value = resName.data;
    }
    if (resThumb.statusCode == 200){
      thumbnailBrand.value = resThumb.data;
    }
    // await database.child('brands/$brand/brandName').once().then((brandName) {
    //   labelBrand.value = brandName.value;
    // });
    // await database.child('brands/$brand/thumbnail').once().then((thumbnail) {
    //   thumbnailBrand.value = thumbnail.value;
    // });
    isLoading.value = false;
  }

  Future<bool> getBranchOfBrand({required String brand}) async {
    var urlBranchs = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brand/branchs.json';
    try{
      var res = await Dio().get(urlBranchs);
      if(res.statusCode == 200){
        var data = Map<String, dynamic>.from(res.data);
        var list = <Branch>[];
        data.forEach(
              (key, value) {
            list.add(Branch(
              branchId: key,
              brandId: brand,
              branchName: value['branchName'],
              address: value['address'],
              district: value['district'],
            ));
            Logger.info(value['branchName']);
          },
        );
        listBranchs.value = list;
      }
      // await database.child('brands/$brand/branchs').get().then(
      //       (event) {
      //     final data = Map<String, dynamic>.from(event.value);
      //     var list = <Branch>[];
      //     data.forEach(
      //           (key, value) {
      //         list.add(Branch(
      //           branchId: key,
      //           brandId: brand,
      //           branchName: value['branchName'],
      //           address: value['address'],
      //           district: value['district'],
      //         ));
      //         Logger.info(value['branchName']);
      //       },
      //     );
      //     listBranchs.value = list;
      //   },
      // );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> getMenuOfBranch({
    required String brand,
    required String idBranch,
    required String branchName,
    required String branchAddress,
    required String branchDistrict,
  }) async {
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brand/branchs/$idBranch/menu.json';
    print('brands/$brand/branchs/$idBranch/menu');
    try{
      isLoading.value = true;
      var res = await Dio().get(url);
      if(res.statusCode == 200){
        var data = Map<String, dynamic>.from(res.data);
        var list = <MenuItem>[];
        data.forEach(
              (key, value) {
            list.add(MenuItem(
              branchId: idBranch,
              brandId: brand,
              menuId: key,
              item: value['item'],
              price: value['price'],
              image: value['image'],
              type: value['type'],
              branchName: branchName,
              address: branchAddress,
              district: branchDistrict,
            ));
            Logger.info("${value['item']}: ID: ${key}");
          },
        );
        listMenu.value = list;
      }
      // await database.child('brands/$brand/branchs/$idBranch/menu').get().then(
      //       (event) {
      //     final data = Map<String, dynamic>.from(event.value);
      //     var list = <MenuItem>[];
      //     data.forEach(
      //           (key, value) {
      //         list.add(MenuItem(
      //           branchId: idBranch,
      //           brandId: brand,
      //           menuId: key,
      //           item: value['item'],
      //           price: value['price'],
      //           image: value['image'],
      //           type: value['type'],
      //           branchName: branchName,
      //           address: branchAddress,
      //           district: branchDistrict,
      //         ));
      //         Logger.info("${value['item']}: ID: ${key}");
      //       },
      //     );
      //     listMenu.value = list;
      //   },
      // );
      isLoading.value = false;
      return true;
    }catch(e){
      print(e);
      isLoading.value = false;
      return false;
    }

  }

  Future<void> getAllBrand() async {
    var urlBranchs = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands.json';
    try{
      var res = await Dio().get(urlBranchs);
      if(res.statusCode == 200){
        var data = Map<String, dynamic>.from(res.data);
        var list = <Brand>[];
        data.forEach(
              (key, value) {
            Logger.info(key);
            list.add(Brand(
                brandId: key,
                brandName: value['brandName'],
                thumbnail: value['thumbnail'],
                closeTime: value['closeTime'],
                openTime: value['openTime']));
          },
        );
        listBrands.value = list;
      }
    }catch(e){

    }
    // database.child('brands').get().then(
    //   (event) {
    //     final data = Map<String, dynamic>.from(event.value);
    //     var list = <Brand>[];
    //     data.forEach(
    //       (key, value) {
    //         Logger.info(key);
    //         list.add(Brand(
    //             brandId: key,
    //             brandName: value['brandName'],
    //             thumbnail: value['thumbnail'],
    //             closeTime: value['closeTime'],
    //             openTime: value['openTime']));
    //       },
    //     );
    //     listBrands.value = list;
    //   },
    // );
  }
  //
  // Future<void> setNewBranchOfBrand(
  //     {required String brand,
  //     required String name,
  //     required String address,
  //     required String district}) async {
  //   final newBranch = <String, dynamic>{
  //     'branchName': name,
  //     'address': address,
  //     'district': district,
  //   };
  //   await database.child('brands/$brand/branchs').push().set(newBranch);
  // }
  //
  // Future<void> setNewMenuOfBranch(
  //     {required String key, required String brand}) async {
  //   final newMenu = <String, dynamic>{
  //     'item': 'Hồng Long Xoài Trân Châu Baby',
  //     'image': 'https://tocotocotea.com/wp-content/uploads/2021/01/ezgif.com-gif-maker-1.jpg',
  //     'price': '22.0000',
  //     'type': 'milkTea',
  //   };
  //   await database.child('brands/$brand/branchs/$key/menu').push().set(newMenu);
  // }
  //
  // Future<void> updateInfoBrand(
  //     {required String brand, required String name}) async {
  //   final newMenu = <String, dynamic>{
  //     'brandName': name,
  //     'openTime': '8:00',
  //     'closeTime': '22:00',
  //   };
  //   await database.child('brands/$brand/').update(newMenu);
  // }
  //
  // Future<void> setNewBrand() async {
  //   final newBrand = {
  //     'brands/royalTea/brandName': 'newBrand',
  //     'brands/royalTea/thumbnail': 'hello',
  //   };
  //   await database.update(newBrand);
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBrand();
    getBanner();
  }
}
