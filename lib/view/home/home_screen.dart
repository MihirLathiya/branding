import 'package:branding/common%20widget/tiles.dart';
import 'package:branding/constant/app_const_string.dart';
import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/controller/home_controller.dart';
import 'package:branding/view/home/view_more_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeScreenController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppString.appName,
          style: FontTextStyle.kBlack24W600Poppins,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.sp,
                ),

                /// CAROUSEL FOR TOP HEADING
                CarouselSlider.builder(
                  carouselController: homeController.carouselController,
                  itemCount: homeController.pages.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
                      height: 180.sp,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(16.sp),
                      ),
                      child: Center(
                        child: Text(
                          itemIndex.toString(),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 180.sp,
                    viewportFraction: 0.9,
                    initialPage: homeController.selectCarouselPage,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    onPageChanged: (index, reason) {
                      homeController.updateCarouselPage(index);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 12.sp,
                ),

                /// INDICATORS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      homeController.pages.length,
                      (index) {
                        return homeController.selectCarouselPage == index
                            ? Container(
                                height: 12.sp,
                                width: 12.sp,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColor.blue0582CA,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 3),
                                ),
                              )
                            : Container(
                                height: 8.sp,
                                width: 8.sp,
                                margin: EdgeInsets.symmetric(horizontal: 6.sp),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.blue0582CA,
                                ),
                              );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 26.sp,
                ),

                /// UPCOMING EVENTS
                HeadingTile(
                  name: 'Upcoming Events',
                  viewMore: () {
                    Get.to(() => ViewMoreScreen(
                          title: 'Upcoming Events',
                        ));
                  },
                ),
                SizedBox(
                  height: 16.sp,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...List.generate(
                        homeController.upcomingEventList.length,
                        (index) {
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(left: 16.sp, right: 8.sp)
                                : EdgeInsets.symmetric(horizontal: 8.0.sp),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  child: CachedNetworkImage(
                                    height: 140.sp,
                                    width: 140.sp,
                                    imageUrl:
                                        '${homeController.upcomingEventList[index]['image']}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Icon(Icons.error_outline),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.4),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.2),
                                      enabled: true,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.sp, vertical: 6.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: AppColor.blue,
                                  ),
                                  child: Text(
                                    '${homeController.upcomingEventList[index]['date']}',
                                    style: FontTextStyle.kWhite16W700Poppins,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.sp,
                ),

                /// Merry Christmas
                HeadingTile(
                  name: 'Merry Christmas',
                  viewMore: () {
                    Get.to(() => ViewMoreScreen(
                          title: 'Merry Christmas',
                        ));
                  },
                ),
                SizedBox(
                  height: 16.sp,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...List.generate(
                        homeController.upcomingEventList.length,
                        (index) {
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(left: 16.sp, right: 8.sp)
                                : EdgeInsets.symmetric(horizontal: 8.0.sp),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  child: CachedNetworkImage(
                                    height: 140.sp,
                                    width: 140.sp,
                                    imageUrl:
                                        '${homeController.upcomingEventList[index]['image']}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Icon(Icons.error_outline),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.4),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.2),
                                      enabled: true,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.sp, vertical: 6.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: AppColor.blue,
                                  ),
                                  child: Text(
                                    '${homeController.upcomingEventList[index]['date']}',
                                    style: FontTextStyle.kWhite16W700Poppins,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.sp,
                ),

                ///Guru Govind Singh Jayanti
                HeadingTile(
                  name: 'Guru Govind Singh Jayanti',
                  viewMore: () {
                    Get.to(() => ViewMoreScreen(
                          title: 'Guru Govind Singh Jayanti',
                        ));
                  },
                ),
                SizedBox(
                  height: 16.sp,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...List.generate(
                        homeController.upcomingEventList.length,
                        (index) {
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(left: 16.sp, right: 8.sp)
                                : EdgeInsets.symmetric(horizontal: 8.0.sp),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  child: CachedNetworkImage(
                                    height: 140.sp,
                                    width: 140.sp,
                                    imageUrl:
                                        '${homeController.upcomingEventList[index]['image']}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Icon(Icons.error_outline),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.4),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.2),
                                      enabled: true,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.sp, vertical: 6.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: AppColor.blue,
                                  ),
                                  child: Text(
                                    '${homeController.upcomingEventList[index]['date']}',
                                    style: FontTextStyle.kWhite16W700Poppins,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.sp,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
