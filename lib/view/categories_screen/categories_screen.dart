import 'package:branding/constant/app_const_string.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  CategoriesController categoriesController = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppString.categories,
          style: FontTextStyle.kBlack24W600Poppins,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CategoriesController>(
        builder: (controller) {
          return MasonryGridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 20.sp,
            crossAxisSpacing: 20.sp,
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return Container(
                height: 80.sp,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.categoriesShadow),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.categories[index],
                  style: FontTextStyle.kWhite18W600Poppins,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
