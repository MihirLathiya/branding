import 'package:branding/constant/image_path.dart';
import 'package:branding/view/business_screen/business_screen.dart';
import 'package:branding/view/categories_screen/categories_screen.dart';
import 'package:branding/view/download_screen/download_screen.dart';
import 'package:branding/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int selectBottomBar = 0;
  List<String> menu = [
    ImagePath.homeMenu,
    ImagePath.businessMenu,
    ImagePath.categoriesMenu,
    ImagePath.downloadMenu,
  ];

  List appScreen = [
    HomeScreen(),
    BusinessScreen(),
    CategoriesScreen(),
    DownloadScreen(),
  ];

  updateBottomIndex(int value) {
    selectBottomBar = value;
    update();
  }
}
