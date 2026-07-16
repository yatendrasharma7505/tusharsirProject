import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';
import '../Utils/app_haptics.dart';
import '../Widgets/custom_text.dart';

class CustomerDatabaseScreen extends StatefulWidget {
  const CustomerDatabaseScreen({super.key});

  @override
  State<CustomerDatabaseScreen> createState() => _CustomerDatabaseScreenState();
}

class _CustomerDatabaseScreenState extends State<CustomerDatabaseScreen> {
  final List<Map<String, dynamic>> customers = [
    {
      "name": "Rajesh Kumar",
      "phone": "+91 98300 11234",
      "city": "Delhi",
      "orders": 14,
      "color": const Color(0xff6672E6),
    },
    {
      "name": "Meena Traders",
      "phone": "+91 99887 55012",
      "city": "Jaipur",
      "orders": 31,
      "color": const Color(0xffEC4B56),
    },
    {
      "name": "Sana Boutique",
      "phone": "+91 90011 22890",
      "city": "Lucknow",
      "orders": 9,
      "color": const Color(0xff1E9C59),
    },
    {
      "name": "Arvind Stores",
      "phone": "+91 97000 33445",
      "city": "Kanpur",
      "orders": 47,
      "color": const Color(0xffD69409),
    },
    {
      "name": "Deepak Mart",
      "phone": "+91 96320 44120",
      "city": "Agra",
      "orders": 22,
      "color": const Color(0xff7D49E8),
    },
    {
      "name": "Lata Fashion",
      "phone": "+91 90909 11003",
      "city": "Noida",
      "orders": 6,
      "color": const Color(0xff1EA4CF),
    },
    {
      "name": "Bhavna Textiles",
      "phone": "+91 99102 78451",
      "city": "Meerut",
      "orders": 18,
      "color": const Color(0xffDD5413),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(12.r), child: _buildTopBar()),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: customers.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return _buildCustomerCard(customers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //---------------------------------------------------
  // TOP BAR
  //---------------------------------------------------

  Widget _buildTopBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () { AppHaptics.tap(); Navigator.pop(context); },
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.fieldFill,
            child: Icon(Icons.arrow_back_ios_new, size: 16.sp),
          ),
        ),

        SizedBox(width: 10.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(text: "Customers", fontSize: 18.sp),

            CustomSubText(text: "${customers.length} saved", fontSize: 13.sp),
          ],
        ),
      ],
    );
  }

  //===================================================
  // CUSTOMER CARD
  //===================================================

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    final initials = customer["name"]
        .toString()
        .split(" ")
        .take(2)
        .map((e) => e[0])
        .join();

    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: () {
        AppHaptics.tap();
      },
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: customer["color"],
              child: Text(
                initials,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitleText(text: customer["name"], fontSize: 15.sp),

                  SizedBox(height: 3.h),

                  CustomSubText(
                    text: "${customer["phone"]} • ${customer["city"]}",
                    fontSize: 11.sp,
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomStatText(
                  text: customer["orders"].toString(),
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),

                SizedBox(height: 2.h),

                CustomSubText(text: "orders", fontSize: 11.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
