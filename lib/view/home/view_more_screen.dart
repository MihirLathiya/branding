import 'package:branding/constant/color.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/constant/image_path.dart';
import 'package:branding/controller/home_controller.dart';
import 'package:branding/view/business_screen/edit_post_screen.dart';
import 'package:branding/view/home/view_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ViewMoreScreen extends StatelessWidget {
  final String? title;
  ViewMoreScreen({Key? key, this.title}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          title!,
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
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Events')
            .orderBy('eventDate', descending: false)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.docs;
            return MasonryGridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20.sp,
              crossAxisSpacing: 20.sp,
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
              itemCount: data?.length,
              itemBuilder: (context, index) {
                DateTime dateOfEvent = DateTime.fromMillisecondsSinceEpoch(
                    (data?[index]['eventDate'] as Timestamp).seconds * 1000);
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ViewMoreImageScreen(
                              title: '${data?[index]['eventName']}',
                              eventId: '${data?[index]['docId']}',
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.sp),
                        child: CachedNetworkImage(
                          height: 189.sp,
                          width: 189.sp,
                          imageUrl: '${data?[index]['imageList'][0]}',
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
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 6.sp),
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 8.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: AppColor.blue,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${DateFormat.MMMd().format(dateOfEvent)}',
                        style: FontTextStyle.kWhite16W700Poppins,
                      ),
                    )
                  ],
                );
              },
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
      ),
    );
  }
}
