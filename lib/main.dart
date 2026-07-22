import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tusharsirproject/OrderDetailScreen/orderDetailScreen.dart';
import 'package:tusharsirproject/Screens/AddOrderManual/AddOrderManualscreen.dart';
import 'package:tusharsirproject/Screens/Home/Homescreen.dart';
import 'package:tusharsirproject/Screens/Login/Loginscreen.dart';
import 'package:tusharsirproject/Screens/Notification/Notificationscreen.dart';
import 'package:tusharsirproject/Screens/Order/Orderscreen.dart';
import 'package:tusharsirproject/Screens/Profile/Profilescreen.dart';
import 'package:tusharsirproject/Screens/Rank/Rankscreen.dart';
import 'package:tusharsirproject/bottom_bar.dart';
import 'Cubits/auth/auth_cubit.dart';
import 'Cubits/category/category_cubit.dart';
import 'Cubits/company/company_cubit.dart';
import 'Cubits/dashboard/dashboard_cubit.dart';
import 'Cubits/employee/employee_cubit.dart';
import 'Cubits/leaderboard/leaderboard_cubit.dart';
import 'Cubits/notification/notification_cubit.dart';
import 'Cubits/order/order_cubit.dart';

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => DashboardCubit()),
            BlocProvider(create: (context) => OrderCubit()),
            BlocProvider(create: (context) => LeaderboardCubit()),
            BlocProvider(create: (context) => NotificationCubit()),
            BlocProvider(create: (context) => EmployeeCubit()),
            BlocProvider(create: (context) => CompanyCubit()),
            BlocProvider(create: (context) => CategoryCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/loginscreen',
            routes: {
              "/loginscreen": (context) => Loginscreen(),
              "/bottombar": (context) => BottomBar(),
              "/homescreen": (context) => Homescreen(),
              "/orderscreen": (context) => Orderscreen(),
              "/addOrderManualscreen": (context) => AddOrderManualscreen(),
              "/rankscreen": (context) => Rankscreen(),
              "/profilescreen": (context) => Profilescreen(),
              "/notificationscreen": (context) => Notificationscreen(),
              "/orderDetailScreen": (context) => OrderDetailScreen(),
            },
          ),
        );
      },
    );
  }
}
