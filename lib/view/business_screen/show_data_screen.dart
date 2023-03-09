import 'dart:convert';

import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/business_controller.dart';
import 'package:branding/hive_model/boxes/boxes.dart';
import 'package:branding/hive_model/business_branding_model.dart';
import 'package:branding/hive_model/personal_branding_model.dart';
import 'package:branding/view/business_screen/Branding_Data/brandig_form_screen.dart';
import 'package:branding/view/business_screen/edit_data/business_data_edit_screen.dart';
import 'package:branding/view/business_screen/edit_data/personal_data_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  bool isCheck = false;
  ShowDataController showDataController = Get.put(ShowDataController());

  // Box<PersonalBrandingModel>? boxPersonalTask;
  // Box<BusinessBrandingModel>? boxBusinessTask;

  @override
  void initState() {
    // boxPersonalTask =
    //     Hive.box<PersonalBrandingModel>(AppConstant.personalDataBoxName);
    // boxBusinessTask =
    //     Hive.box<BusinessBrandingModel>(AppConstant.businessDataBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var boxBusinessTask = Boxes.getBusinessData();
    var boxPersonalTask = Boxes.getPersonalData();
    print('condition == ${boxPersonalTask.length}');
    print('condition == ${boxBusinessTask.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Branding Data', style: FontTextStyle.kBlack20W600Poppins),
        centerTitle: true,
        actions: [buildPopupMenuButton()],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(BrandingFormScreen());
        },
        backgroundColor: AppColor.blue,
        elevation: 0,
        child: Icon(Icons.add_circle_outline, color: AppColor.white),
      ),
      body: boxPersonalTask.length == 0 && boxBusinessTask.length == 0
          ? noData()
          : SafeArea(
              child: dataExist(
                  businessValue: boxBusinessTask,
                  personalValue: boxPersonalTask),
            ),
    );
  }

  Column noData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            ImagePath.noData,
            height: 160.h,
            width: Get.width,
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Text(
          "Plz enter your business data to",
          style: FontTextStyle.kBlack18W600Poppins.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Press “",
                style: FontTextStyle.kBlack18W600Poppins.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                " + ",
                style: FontTextStyle.kBlack18W600Poppins.copyWith(
                    fontWeight: FontWeight.w800, color: AppColor.blue),
              ),
              Text(
                "” option.",
                style: FontTextStyle.kBlack18W600Poppins.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  dataExist({required businessValue, required personalValue}) {
    return GetBuilder<ShowDataController>(
      builder: (controller) {
        return Padding(
          padding: AppConstant.commonPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Business Brand Data
              controller.brand == 3
                  ? SizedBox()
                  : businessValue.length == 0
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Business Branding',
                                style: FontTextStyle.kBlack18W600Poppins
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              // buildPopupMenuButton(controller),
                            ],
                          ),
                        ),
              controller.brand == 3
                  ? SizedBox()
                  : ValueListenableBuilder<Box<BusinessBrandingModel>>(
                      valueListenable: Boxes.getBusinessData().listenable(),
                      builder: (context, value, _) {
                        var data =
                            value.values.toList().cast<BusinessBrandingModel>();
                        return data.isEmpty
                            ? SizedBox()
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: value.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    String _base64 =
                                        base64.encode(data[index].image);
                                    var key = value.keys.toList()[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Container(
                                        height: 130.sp,
                                        width: Get.width,
                                        padding: EdgeInsets.all(10.sp),
                                        decoration: BoxDecoration(
                                            color: AppColor.offWhite,
                                            borderRadius:
                                                BorderRadius.circular(10.sp)),
                                        child: Row(children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 130.sp,
                                              width: 130.sp,
                                              decoration: BoxDecoration(
                                                color: AppColor.black,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp),
                                                child: Image.memory(
                                                    base64Decode(_base64),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.sp,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                          '${data[index].name}',
                                                          style: FontTextStyle
                                                              .kBlack16W600Poppins,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          children: [
                                                            /*IconButton(
                                                                onPressed: () {
                                                                  data[index]
                                                                      .delete();
                                                                  setState(() {});
                                                                },
                                                                icon: Icon(Icons
                                                                    .delete)),*/
                                                            InkWell(
                                                              splashFactory:
                                                                  NoSplash
                                                                      .splashFactory,
                                                              onTap: () {
                                                                Get.to(
                                                                  BusinessDataEditScreen(
                                                                    keyData:
                                                                        key,
                                                                    businessBrandingModel:
                                                                        data[
                                                                            index],
                                                                    address: data[
                                                                            index]
                                                                        .address,
                                                                    email: data[
                                                                            index]
                                                                        .emailId,
                                                                    image: data[
                                                                            index]
                                                                        .image,
                                                                    name: data[
                                                                            index]
                                                                        .name,
                                                                    number: data[
                                                                            index]
                                                                        .contactNumber,
                                                                    website: data[
                                                                            index]
                                                                        .website,
                                                                  ),
                                                                );
                                                                print(
                                                                    'Tap on edit');
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            12.w),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  ImagePath
                                                                      .edit,
                                                                  height: 20.sp,
                                                                  width: 20.sp,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5.sp,
                                                            ),
                                                            SizedBox(
                                                              height: 17.sp,
                                                              width: 17.sp,
                                                              child: Checkbox(
                                                                value: isCheck,
                                                                activeColor:
                                                                    AppColor
                                                                        .blue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    isCheck =
                                                                        value!;
                                                                  });
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${data[index].contactNumber}',
                                                    style: FontTextStyle
                                                        .kBlack12W600Poppins
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColor
                                                                .textGrey),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '${data[index].address}',
                                                      style: FontTextStyle
                                                          .kBlack12W600Poppins
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColor
                                                                  .textGrey),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ]),
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                    ),

              /// Personal Brand Data
              controller.brand == 2
                  ? SizedBox()
                  : personalValue.length == 0
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Personal Branding',
                                style: FontTextStyle.kBlack18W600Poppins
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              // controller.brand == 3
                              //     ? buildPopupMenuButton(controller)
                              //     : SizedBox(),
                            ],
                          ),
                        ),
              controller.brand == 2
                  ? SizedBox()
                  : ValueListenableBuilder<Box<PersonalBrandingModel>>(
                      valueListenable: Boxes.getPersonalData().listenable(),
                      builder: (context, value, _) {
                        var data =
                            value.values.toList().cast<PersonalBrandingModel>();

                        return Expanded(
                          child: ListView.builder(
                            itemCount: value.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              String _base64 = base64.encode(data[index].image);
                              var key = value.keys.toList()[index];

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Container(
                                  height: 130.sp,
                                  width: Get.width,
                                  padding: EdgeInsets.all(10.sp),
                                  decoration: BoxDecoration(
                                      color: AppColor.offWhite,
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  child: Row(children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 130.sp,
                                        width: 130.sp,
                                        decoration: BoxDecoration(
                                          color: AppColor.black,
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          child: Image.memory(
                                              base64Decode(_base64),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 7,
                                                  child: Container(
                                                    // color: Colors.yellow,
                                                    child: Text(
                                                      '${data[index].name}',
                                                      style: FontTextStyle
                                                          .kBlack16W600Poppins,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    // color: Colors.red,
                                                    child: Row(
                                                      children: [
                                                        /*    IconButton(
                                                            onPressed: () {
                                                              data[index].delete();
                                                              setState(() {});
                                                            },
                                                            icon:
                                                                Icon(Icons.delete)),*/
                                                        InkWell(
                                                          splashFactory: NoSplash
                                                              .splashFactory,
                                                          onTap: () {
                                                            Get.to(
                                                                PersonalDataEditScreen(
                                                              keyData: key,
                                                              number: data[
                                                                      index]
                                                                  .contactNumber,
                                                              name: data[index]
                                                                  .name,
                                                              email: data[index]
                                                                  .emailId,
                                                              occupation: data[
                                                                      index]
                                                                  .occupation,
                                                              image: data[index]
                                                                  .image,
                                                            ));
                                                            print(
                                                                'Tap on edit');
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.w),
                                                            child: SvgPicture
                                                                .asset(
                                                              ImagePath.edit,
                                                              height: 20.sp,
                                                              width: 20.sp,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        SizedBox(
                                                          height: 17.sp,
                                                          width: 17.sp,
                                                          child: Checkbox(
                                                            value: isCheck,
                                                            activeColor:
                                                                AppColor.blue,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isCheck =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${data[index].contactNumber}',
                                              style: FontTextStyle
                                                  .kBlack12W600Poppins
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor.textGrey),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${data[index].occupation}',
                                                style: FontTextStyle
                                                    .kBlack12W600Poppins
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColor.textGrey),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ]),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
            ],
          ),
        );
      },
    );
  }

  buildPopupMenuButton() {
    return GetBuilder<ShowDataController>(
      builder: (controller) {
        return PopupMenuButton<int>(
          itemBuilder: (context) => [
            // popupmenu item 1
            PopupMenuItem(
              value: 1,
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              onTap: () {
                controller.setBrand(value: 1);
              },
              child: Center(
                child: Text(
                  "All Brand",
                  style: FontTextStyle.kBlack14W600Poppins
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            // popupmenu item 2
            PopupMenuItem(
              value: 2,
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              onTap: () {
                controller.setBrand(value: 2);
              },
              child: Center(
                child: Text(
                  "Business Brand",
                  style: FontTextStyle.kBlack14W600Poppins
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              onTap: () {
                controller.setBrand(value: 3);
              },
              child: Center(
                child: Text(
                  "Personal Brand",
                  style: FontTextStyle.kBlack14W600Poppins
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
          offset: Offset(0, 45.h),
          color: AppColor.offWhite,
          icon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset(
              ImagePath.filter,
              height: 25.h,
              width: 40.w,
              fit: BoxFit.cover,
            ),
          ),
          elevation: 2,
        );
      },
    );
  }
}
