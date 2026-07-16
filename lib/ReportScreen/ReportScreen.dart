import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int selectedFilter = 1;

  final filters = ["Daily", "Weekly", "Monthly", "By employee", "By company"];

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
                  _buildFilters(),

                  SizedBox(height: 18.h),

                  _buildSummaryCards(),

                  SizedBox(height: 18.h),

                  _buildWeeklyChart(),

                  SizedBox(height: 20.h),

                  _buildStatusReport(),

                  SizedBox(height: 20.h),

                  _buildExportButton(),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------
  // TOP BAR
  //--------------------------------------------------
  //============================================================
  // STATUS REPORT
  //============================================================

  Widget _buildStatusReport() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order status report",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 24.h),

          _statusRow(
            title: "New",
            value: 2,
            progress: .20,
            color: const Color(0xff3465E1),
          ),

          SizedBox(height: 20.h),

          _statusRow(
            title: "Accepted",
            value: 1,
            progress: .10,
            color: const Color(0xff167C78),
          ),

          SizedBox(height: 20.h),

          _statusRow(
            title: "In process",
            value: 1,
            progress: .10,
            color: const Color(0xffB97A00),
          ),

          SizedBox(height: 20.h),

          _statusRow(
            title: "Packed",
            value: 1,
            progress: .10,
            color: const Color(0xff7439E2),
          ),

          SizedBox(height: 20.h),

          _statusRow(
            title: "Completed",
            value: 4,
            progress: .40,
            color: const Color(0xff147A43),
          ),

          SizedBox(height: 20.h),

          _statusRow(
            title: "Cancelled",
            value: 1,
            progress: .10,
            color: const Color(0xffE54848),
          ),
        ],
      ),
    );
  }

  //============================================================
  // STATUS ROW
  //============================================================

  Widget _statusRow({
    required String title,
    required int value,
    required double progress,
    required Color color,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            title,
            style: TextStyle(fontSize: 16.sp, color: Colors.black87),
          ),
        ),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10.h,
              backgroundColor: const Color(0xffE8EDF5),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),

        SizedBox(width: 18.w),

        SizedBox(
          width: 20.w,
          child: Text(
            value.toString(),
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  //============================================================
  // EXPORT BUTTON
  //============================================================

  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      height: 62.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xff1E2635),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
        onPressed: () {},
        icon: Icon(Icons.download_outlined, size: 24.sp),
        label: Text(
          "Export weekly report",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 20.sp),
        ),

        SizedBox(width: 14.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reports",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),

            Text(
              "Performance & exports",
              style: TextStyle(fontSize: 14.sp, color: AppColors.labelGrey),
            ),
          ],
        ),

        const Spacer(),

        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.fieldFill,
              child: Icon(Icons.notifications_none),
            ),

            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //--------------------------------------------------
  // FILTERS
  //--------------------------------------------------

  Widget _buildFilters() {
    return SizedBox(
      height: 52.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final selected = selectedFilter == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
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
              child: Text(
                filters[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //--------------------------------------------------
  // SUMMARY
  //--------------------------------------------------

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            icon: Icons.shopping_bag_outlined,
            iconColor: Colors.teal,
            iconBackground: const Color(0xffE8F6F3),
            value: "258",
            title: "Total orders",
          ),
        ),

        SizedBox(width: 14.w),

        Expanded(
          child: _summaryCard(
            icon: Icons.tag,
            iconColor: Colors.orange,
            iconBackground: const Color(0xffFFF3E5),
            value: "3,420",
            title: "Total pieces",
          ),
        ),
      ],
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String value,
    required String title,
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
            backgroundColor: iconBackground,
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),

          SizedBox(height: 20.h),

          Text(
            value,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 4.h),

          Text(
            title,
            style: TextStyle(color: AppColors.labelGrey, fontSize: 15.sp),
          ),
        ],
      ),
    );
  }

  //--------------------------------------------------
  // WEEKLY CHART
  //--------------------------------------------------

  Widget _buildWeeklyChart() {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly orders trend",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),

          SizedBox(height: 30.h),

          Container(
            height: 220.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.fieldFill.withOpacity(.45),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Center(
              child: Text(
                "Chart goes here\n(fl_chart)",
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SizedBox(height: 18.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Mon"),
              Text("Tue"),
              Text("Wed"),
              Text("Thu"),
              Text("Fri"),
              Text("Sat"),
            ],
          ),
        ],
      ),
    );
  }
}
