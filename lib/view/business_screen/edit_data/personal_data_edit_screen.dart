import 'dart:convert';

import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/business_controller.dart';
import 'package:branding/hive_model/boxes/boxes.dart';
import 'package:branding/hive_model/personal_branding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonalDataEditScreen extends StatefulWidget {
  final String name, number, email, occupation;
  final Uint8List image;
  var keyData;
  PersonalDataEditScreen(
      {Key? key,
      required this.keyData,
      required this.name,
      required this.number,
      required this.email,
      required this.occupation,
      required this.image})
      : super(key: key);

  @override
  State<PersonalDataEditScreen> createState() => _PersonalDataEditScreenState();
}

class _PersonalDataEditScreenState extends State<PersonalDataEditScreen> {
  final _formKey = GlobalKey<FormState>();
  void initState() {
    imageHandler();
    dataAdd();
    super.initState();
  }

  String? _base64;
  imageHandler() {
    _base64 = base64.encode(widget.image);
  }

  PersonalDataEditController personalDataEditController =
      Get.put(PersonalDataEditController());
  dataAdd() {
    personalDataEditController.pNameController.text = widget.name;
    personalDataEditController.pContactNumberController.text = widget.number;
    personalDataEditController.pEmailIdController.text = widget.email;
    personalDataEditController.pOccupationController.text = widget.occupation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: SvgPicture.asset(
              ImagePath.back,
              height: 32.sp,
              width: 32.sp,
            ),
          ),
        ),
        title: Text('Branding Data', style: FontTextStyle.kBlack20W600Poppins),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: GetBuilder<PersonalDataEditController>(
              builder: (controller) {
                return Padding(
                  padding: AppConstant.commonPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.sp,
                      ),

                      /// Image
                      GestureDetector(
                        onTap: controller.getImage,
                        child: Container(
                          height: 147.h,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColor.whiteCream,
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(color: AppColor.blue),
                          ),
                          child: controller.imageFile != null
                              ? Image.file(controller.imageFile!)
                              : widget.image.isNotEmpty
                                  ? Image.memory(base64Decode(_base64!))
                                  : Column(children: [
                                      Padding(
                                        padding: EdgeInsets.all(15.sp),
                                        child: Center(
                                          child: Image.asset(
                                            ImagePath.gallery,
                                            height: 40.sp,
                                            width: 40.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Company-logo.png',
                                        style:
                                            FontTextStyle.kBlack14W600Poppins,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7.sp),
                                            child: CircleAvatar(
                                                radius: 2.sp,
                                                backgroundColor: AppColor.grey),
                                          ),
                                          Text(
                                            'plz upload Your Brand Logo image in .png Formate.',
                                            style: FontTextStyle
                                                .kBlack12W600Poppins
                                                .copyWith(
                                              color: AppColor.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7.sp),
                                            child: CircleAvatar(
                                                radius: 2.sp,
                                                backgroundColor: AppColor.grey),
                                          ),
                                          Text(
                                            'MAX.image size is 250px to 100px.',
                                            style: FontTextStyle
                                                .kBlack12W600Poppins
                                                .copyWith(
                                              color: AppColor.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.sp,
                                      )
                                    ]),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextFiled(
                              controller: controller.pNameController,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Enter Your Name";
                                }
                              },
                              title: "Your Name",
                              hintText: "Enter Your Name"),
                          buildTextFiled(
                              controller: controller.pOccupationController,
                              title: "Occupation",
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Enter Your Occupation";
                                }
                              },
                              hintText: "Enter Occupation"),
                          buildTextFiled(
                              controller: controller.pContactNumberController,
                              maxLength: 10,
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value!.length < 10) {
                                  return "Enter valid Number";
                                }
                              },
                              title: "Contact Number",
                              hintText: "Enter Contact Number"),
                          buildTextFiled(
                              controller: controller.pEmailIdController,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                if (!regex.hasMatch(value!)) {
                                  return "Enter valid Email";
                                }
                              },
                              title: "Email ID",
                              hintText: "Enter Email ID"),
                          SizedBox(
                            height: 80.sp,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                var imageData = controller.imageBytes != null
                                    ? controller.imageBytes
                                    : widget.image;
                                PersonalBrandingModel personalModel =
                                    PersonalBrandingModel(
                                        image: imageData!,
                                        name: controller.pNameController.text,
                                        occupation: controller
                                            .pOccupationController.text,
                                        contactNumber: controller
                                            .pContactNumberController.text,
                                        emailId:
                                            controller.pEmailIdController.text,
                                        dateTime: DateTime.now().toString());

                                final boxBusiness = Boxes.getPersonalData();
                                boxBusiness.put(widget.keyData, personalModel);
                                Get.back();
                                // print('Data == $data');
                              }
                              print('No personal');
                            },
                            child: Container(
                              height: 52.sp,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color:
                                      controller.pNameController.text.isEmpty ||
                                              controller.pEmailIdController.text
                                                  .isEmpty ||
                                              controller
                                                  .pContactNumberController
                                                  .text
                                                  .isEmpty ||
                                              controller.pOccupationController
                                                  .text.isEmpty
                                          ? AppColor.grey
                                          : AppColor.black,
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: Center(
                                child: Text(
                                  'Save Data',
                                  style: FontTextStyle.kBlack20W600Poppins
                                      .copyWith(color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.sp,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildTextFiled(
      {required String title,
      required String hintText,
      required TextEditingController controller,
      int? maxLength,
      String? Function(String?)? validator,
      TextInputType? textInputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.sp, bottom: 8.sp),
          child: Text(
            title,
            style: FontTextStyle.kBlack16W500Poppins,
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          maxLength: maxLength,
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            isDense: true,
            fillColor: AppColor.whiteCream,
            hintText: hintText,
            hintStyle: FontTextStyle.kBlack16W500Poppins
                .copyWith(color: Color(0xff5B6471)),
            contentPadding: EdgeInsets.all(14.sp),
            border: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.sp),
      borderSide: BorderSide(color: AppColor.blue),
    );
  }
}
