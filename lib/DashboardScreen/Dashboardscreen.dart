import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';
import '../../Widgets/custom_text.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedCompany = 0;

  final List<String> companies = [
    "All companies",
    "Shree Textiles",
    "Metro Garments",
  ];
  final orders = [
    {
      "name": "Rajesh Kumar",
      "subtitle": "50 pcs · ST",
      "status": "New",
      "statusColor": Color(0xff2F63F4),
      "statusBg": Color(0xffEEF3FF),
      "icon": Icons.checkroom_outlined,
      "iconBg": Color(0xffDFF3F7),
    },
    {
      "name": "Meena Traders",
      "subtitle": "24 pcs · MG",
      "status": "Accepted",
      "statusColor": Color(0xff127A73),
      "statusBg": Color(0xffE8F8F4),
      "icon": Icons.layers_outlined,
      "iconBg": Color(0xffDFF4EE),
    },
    {
      "name": "Sana Boutique",
      "subtitle": "12 pcs · UT",
      "status": "In process",
      "statusColor": Color(0xffC07A08),
      "statusBg": Color(0xffFFF4DF),
      "icon": Icons.checkroom_outlined,
      "iconBg": Color(0xffEFE6FF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(16.r), child: _buildTopBar()),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  CustomSubText(text: "Manager overview", fontSize: 16.sp),

                  SizedBox(height: 4.h),

                  CustomTitleText(text: "Today at a glance", fontSize: 22.sp),

                  SizedBox(height: 22.h),

                  _buildCompanyFilter(),

                  SizedBox(height: 24.h),

                  _buildStatsGrid(),

                  SizedBox(height: 24.h),

                  _buildTopEmployee(),

                  SizedBox(height: 22.h),

                  _buildQuickActions(),

                  SizedBox(height: 24.h),

                  CustomTitleText(text: "Latest orders", fontSize: 22.sp),

                  SizedBox(height: 16.h),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => SizedBox(height: 18.h),
                    itemBuilder: (_, index) {
                      return _buildOrderCard(orders[index]);
                    },
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //==========================================================
  // TOP BAR
  //==========================================================

  Widget _buildTopEmployee() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: const LinearGradient(
          colors: [Color(0xffF8A03C), Color(0xffF38B22)],
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events, color: Colors.white, size: 42.sp),

          SizedBox(width: 18.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSubText(text: "Top employee of the day", fontSize: 14.sp, color: Colors.white70),

                SizedBox(height: 4.h),

                CustomTitleText(text: "Rahul Sharma", fontSize: 22.sp, color: Colors.white),

                SizedBox(height: 2.h),

                CustomSubText(text: "Shree Textiles", fontSize: 16.sp, color: Colors.white70),
              ],
            ),
          ),

          Column(
            children: [
              CustomText(text: "42", fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),

              CustomSubText(text: "orders", color: Colors.white70),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            icon: Icons.groups_outlined,
            title: "Employees",
            subtitle: "Team & performance",
            iconBg: const Color(0xffEAF8F4),
            iconColor: AppColors.primary,
          ),
        ),

        SizedBox(width: 16.w),

        Expanded(
          child: _actionCard(
            icon: Icons.bar_chart_outlined,
            title: "Reports",
            subtitle: "Daily · weekly · monthly",
            iconBg: const Color(0xffECEBFF),
            iconColor: const Color(0xff5B67D6),
          ),
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor),
          ),

          SizedBox(height: 20.h),

          CustomTitleText(text: title, fontSize: 20.sp),

          SizedBox(height: 6.h),

          CustomSubText(text: subtitle, fontSize: 15.sp),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map order) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Row(
        children: [
          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              color: order["iconBg"],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(order["icon"], color: AppColors.primary, size: 30.sp),
          ),

          SizedBox(width: 18.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitleText(text: order["name"], fontSize: 20.sp),

                SizedBox(height: 4.h),

                CustomSubText(text: order["subtitle"], fontSize: 15.sp),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: order["statusBg"],
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: CustomText(text: order["status"], fontWeight: FontWeight.w600, color: order["statusColor"]),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 22.sp),
        ),

        SizedBox(width: 16.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(text: "OrderDesk", fontSize: 22.sp),

            CustomSubText(text: "Manager view", fontSize: 15.sp),
          ],
        ),

        const Spacer(),

        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.fieldFill,
              child: const Icon(Icons.notifications_none),
            ),

            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 10.w),

        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.fieldFill,
          child: const Icon(Icons.wb_sunny_outlined),
        ),
      ],
    );
  }

  //==========================================================
  // COMPANY FILTER
  //==========================================================

  Widget _buildCompanyFilter() {
    return SizedBox(
      height: 52.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: companies.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (_, index) {
          final selected = selectedCompany == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCompany = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: CustomText(text: companies[index], fontSize: 16.sp, fontWeight: FontWeight.w600, color: selected ? Colors.white : Colors.black87),
            ),
          );
        },
      ),
    );
  }

  //==========================================================
  // STATS GRID
  //==========================================================

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: Icons.groups_outlined,
                iconBg: const Color(0xffECEEFF),
                iconColor: const Color(0xff5B67D6),
                value: "10",
                label: "Employees",
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: _statCard(
                icon: Icons.shopping_bag_outlined,
                iconBg: const Color(0xffE9F6F2),
                iconColor: AppColors.primary,
                value: "6",
                label: "Orders today",
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: _statCard(
                icon: Icons.tag,
                iconBg: const Color(0xffFFF2E6),
                iconColor: Colors.orange,
                value: "212",
                label: "Pieces today",
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: Icons.access_time,
                iconBg: const Color(0xffFFF6E7),
                iconColor: const Color(0xffC7850A),
                value: "5",
                label: "Pending orders",
              ),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: _statCard(
                icon: Icons.check_circle_outline,
                iconBg: const Color(0xffEAF8EE),
                iconColor: Colors.green,
                value: "4",
                label: "Completed",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor),
          ),

          SizedBox(height: 22.h),

          CustomStatText(text: value, fontSize: 22.sp),

          SizedBox(height: 4.h),

          CustomSubText(text: label, fontSize: 15.sp),
        ],
      ),
    );
  }
}
