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
        child: Padding(
          padding: AppConstant.commonPadding,
          child: Column(
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Container(
                height: 56,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Row(children: []),
              ),
              Center(
                child: Text(
                  'Branding Data',
                  style: FontTextStyle.kBlack20W600Poppins,
                ),
              ),
              Center(
                child: Text(
                  'Branding Data',
                  style: FontTextStyle.kBlack20W600Poppins.copyWith(
                      fontWeight: FontWeight.w800, color: AppColor.textGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
