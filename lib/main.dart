import 'package:branding/constant/color.dart';
import 'package:branding/constant/constant.dart';
import 'package:branding/hive_model/business_branding_model.dart';
import 'package:branding/view/bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_model/personal_branding_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(PersonalBrandingModelAdapter());
  Hive.registerAdapter(BusinessBrandingModelAdapter());
  await Hive.openBox<PersonalBrandingModel>(AppConstant.personalDataBoxName);
  await Hive.openBox<BusinessBrandingModel>(AppConstant.businessDataBoxName);
  // await Hive.openBox<DownloadImageModel>(AppConstant.downloadDataBoxName);

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
