import 'package:branding/constant/color.dart';
import 'package:branding/view/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Branding',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "Poppins",
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: AppColor.white,
              appBarTheme: AppBarTheme(color: AppColor.offWhite)),
          home: BottomBarScreen(),
        );
      },
    );
  }
}
