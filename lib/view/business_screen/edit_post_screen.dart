import 'package:branding/constant/color.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/edit_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditPostScreen extends StatefulWidget {
  final String imageLink;
  EditPostScreen({Key? key, required this.imageLink}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen>
    with SingleTickerProviderStateMixin {
  EditPostController editPostController = Get.put(EditPostController());
  TabController? tabController;

  @override
  void initState() {
    tabController =
        TabController(length: editPostController.editType.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Branding Post',
          style: FontTextStyle.kBlack24W600Poppins,
        ),
        centerTitle: true,
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
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Center(
              child: SvgPicture.asset(
                ImagePath.download,
                height: 32.sp,
                width: 32.sp,
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.sp,
        width: Get.width,
        color: AppColor.white,
        padding: EdgeInsets.only(
            left: 16.sp, right: 16.sp, bottom: 16.sp, top: 8.sp),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColor.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Get.generalDialog(
              barrierDismissible: true,
              barrierLabel: '',
              pageBuilder: (BuildContext buildContext, Animation animation,
                  Animation secondaryAnimation) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(16.sp),
                  // this padding user for outside of alert padding
                  insetPadding: EdgeInsets.symmetric(horizontal: 16),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.sp)),
                  content: Container(
                    height: 450.sp,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 366.sp,
                          width: Get.width,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(5, 5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Image.network(
                            '${widget.imageLink}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 51.sp,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColor.black),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Download'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 51.sp,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColor.black),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Share'),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text(
            'Next',
            style: FontTextStyle.kWhite18W600Poppins,
          ),
        ),
      ),
      body: GetBuilder<EditPostController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Container(
                height: 398.sp,
                width: Get.width,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(5, 5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Image.network(
                  '${widget.imageLink}',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 24.sp,
              ),

              /// EDIT  CUSTOM TABBAR
              Container(
                height: 50.sp,
                width: Get.width,
                color: AppColor.offWhite,
                padding: EdgeInsets.only(left: 20.sp),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        controller.editType.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              controller.updateSelectType(index);
                            },
                            child: SizedBox(
                              width: 140.sp,
                              height: 35.sp,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  controller.selectType == index
                                      ? Image.asset(
                                          ImagePath.options,
                                        )
                                      : SizedBox(),
                                  Text(
                                    '${controller.editType[index]}',
                                    style: controller.selectType == index
                                        ? FontTextStyle.kWhite18W600Poppins
                                        : FontTextStyle.kBlack18W600Poppins,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// FOR FRAME
              if (controller.selectType == 0)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.sp, vertical: 20.sp),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7.sp,
                    crossAxisSpacing: 7.sp,
                    itemCount: 10,
                    itemBuilder: (context, frameIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateFrame(frameIndex);
                        },
                        child: Container(
                          height: 128.sp,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColor.grey,
                            border: Border.all(
                              color: controller.selectFrame == frameIndex
                                  ? AppColor.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'FRAME $frameIndex',
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              /// FOR GRAPHIC
              if (controller.selectType == 1)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.sp, vertical: 20.sp),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7.sp,
                    crossAxisSpacing: 7.sp,
                    itemCount: 10,
                    itemBuilder: (context, graphicIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateGraphic(graphicIndex);
                        },
                        child: Container(
                          height: 128.sp,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColor.grey,
                            border: Border.all(
                              color: controller.selectGraphic == graphicIndex
                                  ? AppColor.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'GRAPHIC $graphicIndex',
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              /// FOR POSITION
              if (controller.selectType == 2)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.sp, vertical: 20.sp),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7.sp,
                    crossAxisSpacing: 7.sp,
                    itemCount: 10,
                    itemBuilder: (context, positionIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdatePosition(positionIndex);
                        },
                        child: Container(
                          height: 128.sp,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColor.grey,
                            border: Border.all(
                              color: controller.selectPosition == positionIndex
                                  ? AppColor.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'POSITION $positionIndex',
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              /// FOR FONT
              if (controller.selectType == 3)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.sp, vertical: 20.sp),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7.sp,
                    crossAxisSpacing: 7.sp,
                    itemCount: 10,
                    itemBuilder: (context, fontIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateFont(fontIndex);
                        },
                        child: Container(
                          height: 128.sp,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColor.grey,
                            border: Border.all(
                              color: controller.selectFont == fontIndex
                                  ? AppColor.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'FONT $fontIndex',
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              /// FOR STOKES
              if (controller.selectType == 4)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.sp, vertical: 20.sp),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7.sp,
                    crossAxisSpacing: 7.sp,
                    itemCount: 10,
                    itemBuilder: (context, stockIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateStock(stockIndex);
                        },
                        child: Container(
                          height: 128.sp,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColor.grey,
                            border: Border.all(
                              color: controller.selectStock == stockIndex
                                  ? AppColor.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'STOCK $stockIndex',
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
