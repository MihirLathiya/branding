import 'package:branding/common%20widget/tiles.dart';
import 'package:branding/constant/app_const_string.dart';
import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/controller/home_controller.dart';
import 'package:branding/view/business_screen/edit_post_screen.dart';
import 'package:branding/view/home/view_images.dart';
import 'package:branding/view/home/view_more_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Events')
                .orderBy('eventDate', descending: false)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data?.docs;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.sp,
                      ),

                      /// CAROUSEL FOR TOP HEADING
                      CarouselSlider.builder(
                        carouselController: homeController.carouselController,
                        itemCount: data?.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              height: 180.sp,
                              width: Get.width,
                              imageUrl: '${data?[itemIndex]['imageList'][0]}',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Icon(Icons.error_outline),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.4),
                                  highlightColor: Colors.grey.withOpacity(0.2),
                                  enabled: true,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                );
                              },
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
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
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
                            data!.length,
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
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 6.sp),
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
                          Get.to(
                            () => ViewMoreScreen(
                              title: 'Upcoming Events',
                            ),
                          );
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
                              data.length,
                              (index) {
                                DateTime dateOfEvent =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        (data[index]['eventDate'] as Timestamp)
                                                .seconds *
                                            1000);
                                return Padding(
                                  padding: index == 0
                                      ? EdgeInsets.only(
                                          left: 16.sp, right: 8.sp)
                                      : EdgeInsets.symmetric(
                                          horizontal: 8.0.sp),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ViewMoreImageScreen(
                                            title:
                                                '${data[index]['eventName']}',
                                            eventId: '${data[index]['docId']}',
                                          ));
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                          child: CachedNetworkImage(
                                            height: 140.sp,
                                            width: 140.sp,
                                            imageUrl:
                                                '${data[index]['imageList'][0]}',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Icon(Icons.error_outline),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Shimmer.fromColors(
                                              baseColor:
                                                  Colors.grey.withOpacity(0.4),
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
                                              horizontal: 32.sp,
                                              vertical: 6.sp),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.sp),
                                            color: AppColor.blue,
                                          ),
                                          child: Text(
                                            '${DateFormat.MMMd().format(dateOfEvent)}',
                                            style: FontTextStyle
                                                .kWhite16W700Poppins,
                                          ),
                                        )
                                      ],
                                    ),
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

                      /// Event 1
                      if (data.length >= 1)
                        HeadingTile(
                          name: '${data[0]['eventName']}',
                          viewMore: () {
                            Get.to(() => ViewMoreImageScreen(
                                  title: '${data[0]['eventName']}',
                                  eventId: '${data[0]['docId']}',
                                ));
                          },
                        ),
                      if (data.length >= 1)
                        SizedBox(
                          height: 16.sp,
                        ),
                      if (data.length >= 1)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              ...List.generate(
                                (data[0]['imageList'] as List).length,
                                (index) {
                                  return Padding(
                                    padding: index == 0
                                        ? EdgeInsets.only(
                                            left: 16.sp, right: 8.sp)
                                        : EdgeInsets.symmetric(
                                            horizontal: 8.0.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => EditPostScreen(
                                              imageLink:
                                                  '${data[0]['imageList'][index]}',
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        child: CachedNetworkImage(
                                          height: 140.sp,
                                          width: 140.sp,
                                          imageUrl:
                                              '${data[0]['imageList'][index]}',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Icon(Icons.error_outline),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Shimmer.fromColors(
                                            baseColor:
                                                Colors.grey.withOpacity(0.4),
                                            highlightColor:
                                                Colors.grey.withOpacity(0.2),
                                            enabled: true,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),

                      /// Event 2
                      if (data.length >= 2)
                        HeadingTile(
                          name: '${data[1]['eventName']}',
                          viewMore: () {
                            Get.to(() => ViewMoreImageScreen(
                                  title: '${data[1]['eventName']}',
                                  eventId: '${data[1]['docId']}',
                                ));
                          },
                        ),
                      if (data.length >= 2)
                        SizedBox(
                          height: 16.sp,
                        ),
                      if (data.length >= 2)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              ...List.generate(
                                (data[1]['imageList'] as List).length,
                                (index) {
                                  return Padding(
                                    padding: index == 0
                                        ? EdgeInsets.only(
                                            left: 16.sp, right: 8.sp)
                                        : EdgeInsets.symmetric(
                                            horizontal: 8.0.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => EditPostScreen(
                                              imageLink:
                                                  '${data[1]['imageList'][index]}',
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        child: CachedNetworkImage(
                                          height: 140.sp,
                                          width: 140.sp,
                                          imageUrl:
                                              '${data[1]['imageList'][index]}',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Icon(Icons.error_outline),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Shimmer.fromColors(
                                            baseColor:
                                                Colors.grey.withOpacity(0.4),
                                            highlightColor:
                                                Colors.grey.withOpacity(0.2),
                                            enabled: true,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),

                      /// Event 3
                      if (data.length >= 3)
                        HeadingTile(
                          name: '${data[2]['eventName']}',
                          viewMore: () {
                            Get.to(() => ViewMoreImageScreen(
                                  title: '${data[2]['eventName']}',
                                  eventId: '${data[2]['docId']}',
                                ));
                          },
                        ),
                      if (data.length >= 3)
                        SizedBox(
                          height: 16.sp,
                        ),
                      if (data.length >= 3)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              ...List.generate(
                                (data[2]['imageList'] as List).length,
                                (index) {
                                  return Padding(
                                    padding: index == 0
                                        ? EdgeInsets.only(
                                            left: 16.sp, right: 8.sp)
                                        : EdgeInsets.symmetric(
                                            horizontal: 8.0.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => EditPostScreen(
                                              imageLink:
                                                  '${data[2]['imageList'][index]}',
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        child: CachedNetworkImage(
                                          height: 140.sp,
                                          width: 140.sp,
                                          imageUrl:
                                              '${data[2]['imageList'][index]}',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Icon(Icons.error_outline),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Shimmer.fromColors(
                                            baseColor:
                                                Colors.grey.withOpacity(0.4),
                                            highlightColor:
                                                Colors.grey.withOpacity(0.2),
                                            enabled: true,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Server Error'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
