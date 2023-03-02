import 'package:branding/constant/color.dart';
import 'package:branding/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);
  BottomBarController bottomBarController = Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<BottomBarController>(
        builder: (controller) {
          return Container(
            height: 80.sp,
            width: Get.width,
            color: AppColor.blackFull,
            padding: EdgeInsets.symmetric(horizontal: 22.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  controller.menu.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.updateBottomIndex(index);
                      },
                      child: SvgPicture.asset(
                        controller.menu[index],
                        height:
                            controller.selectBottomBar == index ? 40.sp : 32.sp,
                        width:
                            controller.selectBottomBar == index ? 40.sp : 32.sp,
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      body: GetBuilder<BottomBarController>(
        builder: (bottomController) {
          return bottomController.appScreen[bottomController.selectBottomBar];
        },
      ),
    );
  }
}
// SvgPicture.asset(
// controller.menu[index],
// height: 40.sp,
// width: 40.sp,
// );
