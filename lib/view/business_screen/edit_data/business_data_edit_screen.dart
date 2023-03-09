import 'dart:convert';
import 'dart:io';

import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/business_controller.dart';
import 'package:branding/hive_model/boxes/boxes.dart';
import 'package:branding/hive_model/business_branding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BusinessDataEditScreen extends StatefulWidget {
  final String name, number, email, website, address;
  final Uint8List image;
  var keyData;
  final BusinessBrandingModel businessBrandingModel;
  BusinessDataEditScreen(
      {required this.keyData,
      required this.image,
      required this.name,
      required this.number,
      required this.email,
      required this.website,
      required this.address,
      required this.businessBrandingModel});

  @override
  State<BusinessDataEditScreen> createState() => _BusinessDataEditScreenState();
}

class _BusinessDataEditScreenState extends State<BusinessDataEditScreen> {
  TextEditingController bBrandNameController = TextEditingController();
  TextEditingController bContactNumberController = TextEditingController();
  TextEditingController bEmailIdController = TextEditingController();
  TextEditingController bAddressController = TextEditingController();
  TextEditingController bWebsiteController = TextEditingController();
  @override
  void initState() {
    bBrandNameController.addListener(() {
      setState(() {});
    });
    bContactNumberController.addListener(() {
      setState(() {});
    });
    bEmailIdController.addListener(() {
      setState(() {});
    });
    bWebsiteController.addListener(() {
      setState(() {});
    });
    bAddressController.addListener(() {
      setState(() {});
    });
    dataAdd();
    imageHandler();
    fileConvert(imageInUnit8List: widget.image);

    super.initState();
  }

  BusinessDataEditController businessDataEditController =
      Get.put(BusinessDataEditController());

  String? _base64;
  imageHandler() {
    _base64 = base64.encode(widget.image);
  }

  dataAdd() {
    bBrandNameController.text = widget.name;
    bContactNumberController.text = widget.number;
    bEmailIdController.text = widget.email;
    bWebsiteController.text = widget.website;
    bAddressController.text = widget.address;
  }

  File? file;
  fileConvert({required Uint8List imageInUnit8List}) async {
    // Uint8List? imageInUnit8List; // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    file = await File('${tempDir.path}/image.png').create();
    file!.writeAsBytesSync(imageInUnit8List);
    setState(() {});
    return file;
  }

  final _formKey = GlobalKey<FormState>();
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
        child: GetBuilder<BusinessDataEditController>(
          builder: (controller) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: AppConstant.commonPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.sp,
                      ),
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
                          // child: Image.file(file!),
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
                              controller: bBrandNameController,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Enter Brand Name";
                                }
                              },
                              title: "Brand Name",
                              hintText: "Enter Brand Name"),
                          buildTextFiled(
                              controller: bContactNumberController,
                              validator: (value) {
                                if (value!.length < 10) {
                                  return "Enter valid Number";
                                }
                              },
                              textInputType: TextInputType.phone,
                              title: "Contact Number",
                              maxLength: 10,
                              hintText: "Enter Contact Number"),
                          buildTextFiled(
                              controller: bEmailIdController,
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
                          buildTextFiled(
                              controller: bWebsiteController,
                              textInputType: TextInputType.url,
                              title: "Website URL",
                              hintText: "Enter Website URL"),
                          buildTextFiled(
                              controller: bAddressController,
                              textInputType: TextInputType.streetAddress,
                              title: "Address",
                              hintText: "Enter Business Address"),
                          SizedBox(
                            height: 80.sp,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                var imageData = controller.imageBytes != null
                                    ? controller.imageBytes
                                    : widget.image;
                                print('YES');
                                BusinessBrandingModel businessModel =
                                    BusinessBrandingModel(
                                        image: imageData!,
                                        website: bWebsiteController.text,
                                        address: bAddressController.text,
                                        name: bBrandNameController.text,
                                        contactNumber:
                                            bContactNumberController.text,
                                        emailId: bEmailIdController.text,
                                        dateTime: DateTime.now().toString());
                                // print('MODEL image++ ${businessModel.image}');
                                // print('MODEL name++ ${businessModel.name}');
                                // print(
                                //     'MODEL address++ ${businessModel.address}');
                                // print(
                                //     'MODEL website++ ${businessModel.website}');
                                // print('MODEL email++ ${businessModel.emailId}');
                                // print(
                                //     'MODEL contact++ ${businessModel.contactNumber}');
                                // print(
                                //     'MODEL contact++ ${businessModel.dateTime}');
                                // print('keyData == ${widget.keyData}');
                                final boxBusiness = Boxes.getBusinessData();
                                boxBusiness.put(widget.keyData, businessModel);
                                Get.back();
                              } else {
                                print('NO');
                              }
                            },
                            child: Container(
                              height: 52.sp,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: bBrandNameController.text.isEmpty ||
                                          bAddressController.text.isEmpty ||
                                          bWebsiteController.text.isEmpty ||
                                          bEmailIdController.text.isEmpty ||
                                          bContactNumberController.text.isEmpty
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
                ),
              ),
            );
          },
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
