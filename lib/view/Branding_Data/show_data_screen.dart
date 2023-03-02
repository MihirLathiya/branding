import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/view/Branding_Data/data_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branding Data', style: FontTextStyle.kBlack20W600Poppins),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(DataForm());
        },
        backgroundColor: AppColor.blue,
        elevation: 0,
        child: Icon(Icons.add_circle_outline, color: AppColor.white),
      ),
      body: SafeArea(
        child: buildSafeArea(),
      ),
    );
  }

  Column noData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
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

  Padding buildSafeArea() {
    return Padding(
      padding: AppConstant.commonPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.sp),
            child: Text(
              'Business Branding',
              style: FontTextStyle.kBlack18W600Poppins
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 130.sp,
            width: Get.width,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
                color: AppColor.offWhite,
                borderRadius: BorderRadius.circular(10.sp)),
            child: Row(children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
              ),
              SizedBox(
                width: 10.sp,
              ),
              Expanded(
                flex: 5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Business Name',
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                          Row(
                            children: [
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  print('Tap on edit');
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Image.asset(
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
                                  activeColor: AppColor.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      isCheck = value!;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '+91 00000 00000',
                        style: FontTextStyle.kBlack12W600Poppins.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.textGrey),
                      ),
                      Flexible(
                        child: Text(
                          '502, Murida Rd, Murida, Borda, Margao, Goa India-403602.',
                          style: FontTextStyle.kBlack12W600Poppins.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.textGrey),
                        ),
                      ),
                    ]),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
