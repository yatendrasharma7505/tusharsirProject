import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';
import '../Utils/app_haptics.dart';
import '../Widgets/custom_text.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  int selectedCompany = 2;

  final List<String> companies = [
    "All companies",
    "Shree Textiles",
    "Metro Garments",
  ];
  final employees = [
    {
      "name": "Amit Verma",
      "role": "Order Executive",
      "id": "E02",
      "company": "Metro Garments",
      "orders": 35,
      "pieces": 220,
      "performance": 0.91,
      "color": Color(0xff149A92),
      "progressColor": Color(0xff1DA851),
    },
    {
      "name": "Vikram Rao",
      "role": "Dispatch",
      "id": "E05",
      "company": "Metro Garments",
      "orders": 24,
      "pieces": 168,
      "performance": 0.82,
      "color": Color(0xffF39A35),
      "progressColor": Color(0xffF7A03F),
    },
    {
      "name": "Pooja Nair",
      "role": "Order Executive",
      "id": "E08",
      "company": "Metro Garments",
      "orders": 16,
      "pieces": 118,
      "performance": 0.73,
      "color": Color(0xff6672E6),
      "progressColor": Color(0xffF7A03F),
    },
  ];
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(12.r), child: _buildTopBar()),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                children: [
                  _buildAddEmployeeButton(),

                  SizedBox(height: 12.h),

                  _buildCompanyFilter(),

                  SizedBox(height: 12.h),

                  _buildSearchField(),

                  SizedBox(height: 14.h),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: employees.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (_, index) {
                      return _buildEmployeeCard(employees[index]);
                    },
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(Map employee) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: employee["color"],
                child: Text(
                  employee["name"].split(" ").map((e) => e[0]).join(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleText(text: employee["name"], fontSize: 15.sp),

                    SizedBox(height: 2.h),

                    CustomSubText(
                      text: "${employee["role"]} • ${employee["id"]}",
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),

              CustomBadgeText(
                text: "• ${employee["company"]}",
                fontSize: 11.sp,
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Divider(),

          SizedBox(height: 8.h),

          Row(
            children: [
              _stat(employee["orders"].toString(), "orders"),

              SizedBox(width: 20.w),

              _stat(employee["pieces"].toString(), "pieces"),

              const Spacer(),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: LinearProgressIndicator(
                    value: employee["performance"],
                    minHeight: 8.h,
                    backgroundColor: const Color(0xffE8EDF5),
                    valueColor: AlwaysStoppedAnimation(
                      employee["progressColor"],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              CustomStatText(
                text: "${(employee["performance"] * 100).toInt()}%",
                fontSize: 14.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomStatText(text: value, fontSize: 16.sp),

        SizedBox(height: 2.h),

        CustomSubText(text: title, fontSize: 12.sp),
      ],
    );
  }

  //---------------------------------------------------
  // TOP BAR
  //---------------------------------------------------

  Widget _buildTopBar() {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 16.sp),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(text: "Team", fontSize: 16.sp),
            CustomSubText(text: "10 employees", fontSize: 11.sp),
          ],
        ),
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AppColors.fieldFill,
              child: Icon(Icons.notifications_none, size: 16.sp),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
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

  //---------------------------------------------------
  // ADD EMPLOYEE BUTTON
  //---------------------------------------------------

  Widget _buildAddEmployeeButton() {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton.icon(
        onPressed: () { AppHaptics.tap(); },
        icon: Icon(Icons.person_add_alt_1, color: Colors.white, size: 18.sp),
        label: CustomText(
          text: "Add employee",
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }

  //---------------------------------------------------
  // COMPANY FILTER
  //---------------------------------------------------

  Widget _buildCompanyFilter() {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: companies.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (_, index) {
          final selected = selectedCompany == index;

          return GestureDetector(
            onTap: () {
              AppHaptics.tap();
              setState(() {
                selectedCompany = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? const Color(0xff5B67D6) : Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: CustomText(
                text: companies[index],
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }

  //---------------------------------------------------
  // SEARCH BAR
  //---------------------------------------------------

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: "Search employees",
        hintStyle: TextStyle(fontSize: 14.sp),
        prefixIcon: Icon(Icons.search, size: 18.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
