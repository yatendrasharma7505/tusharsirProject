import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tusharsirproject/CustomerdatabseScreen/customerdatabasescreen.dart';
import 'package:tusharsirproject/Screens/AddOrderManual/AddOrderManualscreen.dart';
import 'package:tusharsirproject/Screens/Home/Homescreen.dart';
import 'package:tusharsirproject/Screens/Login/Loginscreen.dart';
import 'package:tusharsirproject/Screens/Notification/Notificationscreen.dart';
import 'package:tusharsirproject/Screens/Order/Orderscreen.dart';
import 'package:tusharsirproject/Screens/Profile/Profilescreen.dart';
import 'package:tusharsirproject/Screens/Rank/Rankscreen.dart';
import 'package:tusharsirproject/adminbottombar.dart';
import 'package:tusharsirproject/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: AddEmployeeScreen(),
          initialRoute: '/loginscreen',

          routes: {
            "/loginscreen": (context) => Loginscreen(),
            "/bottombar": (context) => BottomBar(),
            "/homescreen": (context) => Homescreen(),
            "/adminbottombar": (context) => Adminbottombar(),
            "/orderscreen": (context) => Orderscreen(),
            "/addOrderManualscreen": (context) => AddOrderManualscreen(),
            "/rankscreen": (context) => Rankscreen(),
            "/profilescreen": (context) => Profilescreen(),
            "/notificationscreen": (context) => Notificationscreen(),
            "/customerDatabaseScreen": (context) => CustomerDatabaseScreen(),
          },
        );
      },
    );
  }
}
