import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDataFormController extends GetxController {
  final picker = ImagePicker();
  Uint8List? imageBytes;
  String? base64String;
  File? imageFile;

  Future getImage() async {
    base64String = null;
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      base64String = base64.encode(imageBytes!);
      imageFile = File(pickedFile.path);
    }
    update();
  }
}

class BusinessDataFormController extends GetxController {
  final picker = ImagePicker();
  Uint8List? imageBytes;
  String? base64String;
  File? imageFile;

  Future getImage() async {
    base64String = null;
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      base64String = base64.encode(imageBytes!);
      imageFile = File(pickedFile.path);
    }
    update();
  }
}

class ShowDataController extends GetxController {
  int brand = 1;

  setBrand({required value}) {
    brand = value;
    print('Brand selected == $brand');
    update();
  }
}

class BusinessDataEditController extends GetxController {
  final picker = ImagePicker();
  Uint8List? imageBytes;
  String? base64String;
  File? imageFile;

  Future getImage() async {
    base64String = null;
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      base64String = base64.encode(imageBytes!);
      imageFile = File(pickedFile.path);
    }
    update();
  }
}

class PersonalDataEditController extends GetxController {
  TextEditingController pNameController = TextEditingController();
  TextEditingController pContactNumberController = TextEditingController();
  TextEditingController pEmailIdController = TextEditingController();
  TextEditingController pOccupationController = TextEditingController();
  final picker = ImagePicker();
  Uint8List? imageBytes;
  String? base64String;
  File? imageFile;

  Future getImage() async {
    base64String = null;
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      base64String = base64.encode(imageBytes!);
      imageFile = File(pickedFile.path);
    }
    update();
  }

  textFiledListener() {
    pNameController.addListener(() {
      update();
    });
    pContactNumberController.addListener(() {
      update();
    });
    pEmailIdController.addListener(() {
      update();
    });
    pOccupationController.addListener(() {
      update();
    });
  }

  @override
  void onInit() {
    textFiledListener();
    super.onInit();
  }
}
