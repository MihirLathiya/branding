import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostController extends GetxController {
  /// FOR TAB BAR
  List<String> editType = [
    'Frame',
    'Graphic',
    'Logo Position',
    'Fonts',
    'Stokes'
  ];

  /// FOR TAB BAR
  int selectType = 0;

  /// FOR SELECT FRAME
  int selectFrame = 0;

  /// FOR SELECT GRAPHIC
  int selectGraphic = 0;

  /// FOR SELECT POSITION
  int selectPosition = 0;

  /// FOR SELECT STOCK
  int selectStock = 0;

  /// FOR SELECT FONT
  int selectFont = 0;

  /// FOR TAB BAR
  updateSelectType(int value) {
    selectType = value;
    update();
  }

  /// FOR UPDATE FRAME
  updateUpdateFrame(int value) {
    selectFrame = value;
    update();
  }

  /// FOR UPDATE GRAPHIC
  updateUpdateGraphic(int value) {
    selectGraphic = value;
    update();
  }

  /// FOR UPDATE POSITION
  updateUpdatePosition(int value) {
    selectPosition = value;
    update();
  }

  /// FOR UPDATE STOCK
  updateUpdateStock(int value) {
    selectStock = value;
    update();
  }

  /// FOR UPDATE FONT
  updateUpdateFont(int value) {
    selectFont = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
