// import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:tako_dashbroad/models/brand_model.dart';
import 'package:tako_dashbroad/models/common/category_menu_item.dart';
import 'package:tako_dashbroad/util/common/logger.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  RxString pathBanner1 = "https://".obs;
  RxString pathBanner2 = ''.obs;
  RxString pathBanner3 = ''.obs;
  RxBool isLoading = false.obs;
  var listBrands = <Brand>[].obs;
  var listBranchs = <Branch>[].obs;
  var listMenu = <MenuItem>[].obs;
  var branch = Branch().obs;
  var listCategoryMenu = <CategoryMenu>[].obs;
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
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> getMenuOfBranch({
    required String brand,
    required String idBranch,
     String? branchName,
     String? branchAddress,
     String? branchDistrict,
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
              description: value['description'],
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
      isLoading.value = false;
      return true;
    }catch(e){
      print(e);
      isLoading.value = false;
      return false;
    }

  }

  Future<bool> getCategoryMenu({required String categoryKey}) async {
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/category/$categoryKey/menu.json';
    try{
      isLoading.value = true;
      var res = await Dio().get(url);
      if(res.statusCode == 200){
        var data = Map<String, dynamic>.from(res.data);
        var list = <CategoryMenu>[];
        data.forEach((key, value) {
          Logger.info(key);
          list.add(
            CategoryMenu(
              id: key,
              categoryType: categoryKey,
              image: value['imageUrl'],
              item: value['item'],
              price: value['price'],
              address: value['address'],
              description: value['description'],
            ),
          );
        });
        listCategoryMenu.value = list;
      }
      isLoading.value = false;
      return true;
    }catch(e){
      isLoading.value = false;
      return false;
    }
  }

  Future<void> setNewCategoryMenu({required String categoryType,required String description, required String menuId, required String itemName, required String price,required String imageUrl,required String address}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/category/$categoryType/menu/$menuId.json';
    await Dio().patch(url, data: {
      'item': itemName,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
      'address': address,
    });
    getCategoryMenu(categoryKey: categoryType);
    isLoading.value = false;
  }

  Future<void> deleteCategoryMenu({required String categoryType, required String menuId}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/category/$categoryType/menu/$menuId.json';
    await Dio().delete(url);
    Get.back();
    isLoading.value = false;
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
  }

  Future<void> setNewBranch({String? branchName, String? branchAddress, String? district, required String brandId, required String branchId}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brandId/branchs/$branchId.json';
    await Dio().patch(url, data: {
      'branchName': branchName,
      'address': branchAddress,
      'district': district,
    });
    isLoading.value = false;
    getBranchOfBrand(brand: brandId);
  }

  Future<void> deleteBranch({required String brandId, required String branchId}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brandId/branchs/$branchId.json';
    await Dio().delete(url);
    Get.back();
    isLoading.value = false;
  }

  Future<void> setNewMenuOfBranch({required String brandId, required String branchId,required String description, required String menuId, required String itemName, required String price,required String imageUrl,required String type}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brandId/branchs/$branchId/menu/$menuId.json';
    await Dio().patch(url, data: {
      'item': itemName,
      'image': imageUrl,
      'price': price,
      'description': description,
      'type': type,
    });
    getMenuOfBranch(brand: brandId, idBranch: branchId);
    isLoading.value = false;
  }

  Future<void> deleteMenu({required String brandId, required String branchId, required String menuId}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$brandId/branchs/$branchId/menu/$menuId.json';
    await Dio().delete(url);
    Get.back();
    isLoading.value = false;
  }

  Future<void> setNewBrand({required String brandName, required String thumbnail, required String id}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$id.json';
    await Dio().patch(url, data: {
      'brandName': brandName,
      'thumbnail': thumbnail,
      'closeTime': '22:00',
      'openTime': '8:00',
    });
    getInfoBrand(brand: id);
    isLoading.value = false;
    getAllBrand();
  }


  Future<void> deleteBrand({required String id}) async {
    isLoading.value = true;
    var url = 'https://tako-5d6a2-default-rtdb.firebaseio.com/brands/$id.json';
    await Dio().delete(url);
    getInfoBrand(brand: id);
    isLoading.value = false;
    getAllBrand();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBrand();
    getBanner();
  }
}
