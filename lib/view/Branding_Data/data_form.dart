import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DataForm extends StatefulWidget {
  const DataForm({Key? key}) : super(key: key);

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  /// Business
  TextEditingController bBrandNameController = TextEditingController();
  TextEditingController bContactNumberController = TextEditingController();
  TextEditingController bEmailIdController = TextEditingController();
  TextEditingController bAddressController = TextEditingController();
  TextEditingController bWebsiteController = TextEditingController();

  /// Personal
  TextEditingController pNameController = TextEditingController();
  TextEditingController pContactNumberController = TextEditingController();
  TextEditingController pEmailIdController = TextEditingController();
  TextEditingController pOccupationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          ImagePath.back,
          height: 32.sp,
          width: 32.sp,
        ),
        title: Text('Branding Data', style: FontTextStyle.kBlack20W600Poppins),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: AppConstant.commonPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                        color: AppColor.offWhite,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Container(
                      height: 40.sp,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColor.offWhite,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: TabBar(
                          indicatorColor: Colors.transparent,
                          physics: NeverScrollableScrollPhysics(),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: AppColor.white,
                          labelStyle: FontTextStyle.kBlack16W600Poppins,
                          unselectedLabelColor: AppColor.black,
                          unselectedLabelStyle:
                              FontTextStyle.kBlack16W600Poppins,
                          indicator: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(8.sp)),
                          tabs: const [
                            Tab(
                              child: Center(
                                child: Text(
                                  'Business',
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Personal',
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        buildBusinessForm(),
                        buildPersonalForm(),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  buildBusinessForm() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColor.whiteCream,
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(color: AppColor.blue),
            ),
            child: Column(children: [
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
                style: FontTextStyle.kBlack14W600Poppins,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp),
                    child: CircleAvatar(
                        radius: 2.sp, backgroundColor: AppColor.grey),
                  ),
                  Text(
                    'plz upload Your Brand Logo image in .png Formate.',
                    style: FontTextStyle.kBlack12W600Poppins.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp),
                    child: CircleAvatar(
                        radius: 2.sp, backgroundColor: AppColor.grey),
                  ),
                  Text(
                    'MAX.image size is 250px to 100px.',
                    style: FontTextStyle.kBlack12W600Poppins.copyWith(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFiled(
                  controller: bBrandNameController,
                  title: "Brand Name",
                  hintText: "Enter Brand Name"),
              buildTextFiled(
                  controller: bContactNumberController,
                  title: "Contact Number",
                  hintText: "Enter Contact Number"),
              buildTextFiled(
                  controller: bEmailIdController,
                  title: "Email ID",
                  hintText: "Enter Email ID"),
              buildTextFiled(
                  controller: bWebsiteController,
                  title: "Website URL",
                  hintText: "Enter Website URL"),
              buildTextFiled(
                  controller: bAddressController,
                  title: "Website URL",
                  hintText: "Enter Business Address"),
              SizedBox(
                height: 80.sp,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52.sp,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Center(
                    child: Text(
                      'Save Data',
                      style: FontTextStyle.kBlack20W600Poppins
                          .copyWith(color: AppColor.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildPersonalForm() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColor.whiteCream,
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(color: AppColor.blue),
            ),
            child: Column(children: [
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
                style: FontTextStyle.kBlack14W600Poppins,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp),
                    child: CircleAvatar(
                        radius: 2.sp, backgroundColor: AppColor.grey),
                  ),
                  Text(
                    'plz upload Your Brand Logo image in .png Formate.',
                    style: FontTextStyle.kBlack12W600Poppins.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp),
                    child: CircleAvatar(
                        radius: 2.sp, backgroundColor: AppColor.grey),
                  ),
                  Text(
                    'MAX.image size is 250px to 100px.',
                    style: FontTextStyle.kBlack12W600Poppins.copyWith(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFiled(
                  controller: pNameController,
                  title: "Your Name",
                  hintText: "Enter Your Name"),
              buildTextFiled(
                  controller: pOccupationController,
                  title: "Occupation",
                  hintText: "Enter Occupation"),
              buildTextFiled(
                  controller: pContactNumberController,
                  title: "Contact Number",
                  hintText: "Enter Contact Number"),
              buildTextFiled(
                  controller: pEmailIdController,
                  title: "Email ID",
                  hintText: "Enter Email ID"),
              SizedBox(
                height: 80.sp,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52.sp,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Center(
                    child: Text(
                      'Save Data',
                      style: FontTextStyle.kBlack20W600Poppins
                          .copyWith(color: AppColor.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Column buildTextFiled({
    required String title,
    required String hintText,
    required TextEditingController controller,
  }) {
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
          decoration: InputDecoration(
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
