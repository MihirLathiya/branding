import 'package:branding/constant/app_const_string.dart';
import 'package:branding/constant/font_style.dart';
import 'package:branding/controller/download_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({Key? key}) : super(key: key);
  DownloadController downloadController = Get.put(DownloadController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppString.download,
          style: FontTextStyle.kBlack24W600Poppins,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<DownloadController>(
        builder: (controller) {
          return MasonryGridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 20.sp,
            crossAxisSpacing: 20.sp,
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
            itemCount: controller.downloadList.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: CachedNetworkImage(
                  height: 189.sp,
                  width: 189.sp,
                  imageUrl: '${controller.downloadList[index]['image']}',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(Icons.error_outline),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.4),
                    highlightColor: Colors.grey.withOpacity(0.2),
                    enabled: true,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
