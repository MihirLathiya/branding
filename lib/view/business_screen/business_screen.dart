import 'package:branding/constant/app_const_string.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/business_controller.dart';
import 'package:branding/view/business_screen/Branding_Data/brandig_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key}) : super(key: key);
  BusinessController businessController = Get.put(BusinessController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppString.branding,
          style: FontTextStyle.kBlack24W600Poppins,
        ),
        centerTitle: true,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => BrandingFormScreen());
        },
        child: SvgPicture.asset(
          ImagePath.floatingButton,
          height: 72.sp,
          width: 72.sp,
          fit: BoxFit.cover,
        ),
      ),
      body: GetBuilder<BusinessController>(
        builder: (controller) {
          return controller.data.isEmpty
              ? buildEmptyData()
              : Column(
                  children: [],
                );
        },
      ),
    );
  }

  Center buildEmptyData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImagePath.noData,
            height: 154.sp,
            width: 238.sp,
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            'Plz enter your business data to',
            style: FontTextStyle.kBlack18W600Poppins,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Press “ ',
                style: FontTextStyle.kBlack18W600Poppins,
              ),
              Text(
                '+',
                style: FontTextStyle.kBlue18W900Poppins,
              ),
              Text(
                ' “ option.',
                style: FontTextStyle.kBlack18W600Poppins,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
