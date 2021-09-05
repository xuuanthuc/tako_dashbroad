import 'package:get/get.dart';
import 'package:tako_dashbroad/modules/home/pages/banner/banner_edit_page.dart';
import 'package:tako_dashbroad/modules/home/pages/brands/edit_or_addNew_brand.dart';
import 'package:tako_dashbroad/modules/home/pages/categories/list_categories_page.dart';
import 'package:tako_dashbroad/modules/home/pages/categories/list_menu.dart';

import 'modules/authentication/auth_binding.dart';
import 'modules/authentication/pages/auth_page.dart';
import 'modules/authentication/pages/forgot_password.dart';
import 'modules/common/empty_page.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/pages/brands/branchs/listview_branchs_of_brand.dart';
import 'modules/home/pages/brands/branchs/menu/list_menu_management.dart';
import 'modules/home/pages/brands/listview_brands_page.dart';
import 'modules/home/pages/home_page.dart';
import 'modules/settings/setting_page.dart';

abstract class Routes {
  static const HOME = '/home_page';
  static const AUTH = '/auth_screen';
  static const FORGOT_PASS = '/forgot-password-screen';
  static const LISTBRANDS  = '/list-brands';
  static const BRANCHS_OF_BRAND  = '/list-branchs-of-brand';
  static const MENU_ITEM  = '/list_menu_item-of-branch';
  static const ORDER  = '/order_item_page';
  static const SETTING = '/setting';
  static const EMPTY = '/empty-page';
  static const EDIT_BRAND = '/edit-brand-page';
  static const CATEGORY = '/list-category-page';
  static const CATEGORY_MENU = '/list-menu-category-page';


  static const BANNER_MANAGEMENT = '/BannerManagement-page';


}

class AppPages {
  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      bindings: [HomeBinding(), AuthBinding()]
    ),
    GetPage(
        name: Routes.BANNER_MANAGEMENT,
        page: () => BannerManagement(),
        bindings: [HomeBinding()]
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),

    ),
    GetPage(
      name: Routes.FORGOT_PASS,
      page: () => ForgotpasswordScreen(),
    ),
    GetPage(
      name: Routes.LISTBRANDS,
      page: () => ListBrandsPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BRANCHS_OF_BRAND,
      page: () => ListBranchsOfBrandPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.MENU_ITEM,
      page: () => MenuManagement(),
      bindings: [HomeBinding()]
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingScreen(),
      bindings: [ AuthBinding(),HomeBinding()],
    ),
    GetPage(
      name: Routes.EMPTY,
      page: () => EmptyPage(),
    ),
    GetPage(
      name: Routes.EDIT_BRAND,
      page: () => EditOrAddBrand(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: Routes.CATEGORY,
      page: () => ListCategoriesScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: Routes.CATEGORY_MENU,
      page: () => MenuListCategory(),
      bindings: [HomeBinding()],
    ),
  ];
}

// can add route children by that
// GetPage(
//   name: Routes.HOME,
//   page: () => HomeWeatherPage(),
//   binding: WeatherBinding(),
//   children: [
//     GetPage(
//     name: Routes.CITY_SEARCH,
//     page: () => CitySearchPage(),
//     ),
//     GetPage(
//     name: Routes.SETTING,
//     page: () => SettingLangPage(),
//     ),
//   ]
// ),
