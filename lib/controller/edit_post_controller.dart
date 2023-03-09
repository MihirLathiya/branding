import 'package:branding/constant/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class EditPostController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();

  /// FOR TAB BAR
  List<String> editType = [
    'Frame',
    'Graphic',
    'Logo Position',
    'Fonts',
    'Stokes'
  ];

  /// FOR POSITION
  List<String> positionList = [
    'Top-Left',
    'Top-Center',
    'Top-Right',
    'Down-Left',
    'Down-Center',
    'Down-Right',
  ];

  /// FRAME LIST
  List<String> frameList = [
    ImagePath.frame1,
    ImagePath.frame2,
    ImagePath.frame3,
    ImagePath.frame4,
    ImagePath.frame5
  ];

  /// FOR TAB BAR
  int selectType = 0;

  /// FOR SELECT FRAME
  int selectFrame = -1;

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
