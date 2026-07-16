import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Widgets/custom_text.dart';

class Setingscreen extends StatefulWidget {
  const Setingscreen({super.key});

  @override
  State<Setingscreen> createState() => _SetingscreenState();
}

class _SetingscreenState extends State<Setingscreen> {
  bool darkMode = false;
  bool adminMode = true;

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
                  _buildProfileCard(),

                  SizedBox(height: 12.h),

                  _buildSettingsCard(),

                  SizedBox(height: 12.h),

                  _buildSwitchView(),

                  SizedBox(height: 12.h),

                  _buildLogout(),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=========================================================
  // TOP BAR
  //=========================================================

  Widget _buildTopBar() {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 16.sp),
        ),

        SizedBox(width: 10.w),

        CustomTitleText(text: "Settings", fontSize: 18.sp),

        const Spacer(),

        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AppColors.fieldFill,
              child: Icon(Icons.notifications_none, size: 18.sp),
            ),

            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 8,
                width: 8,
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

  //=========================================================
  // PROFILE CARD
  //=========================================================

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xffFFF3E5),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.workspace_premium_outlined,
              color: Colors.orange,
              size: 22.sp,
            ),
          ),

          SizedBox(width: 12.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleText(text: "Manager", fontSize: 16.sp),

              SizedBox(height: 2.h),

              CustomSubText(
                text: "Full access • OrderDesk Pro",
                fontSize: 13.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //=========================================================
  // SETTINGS LIST
  //=========================================================

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          _tile(
            icon: Icons.storage_outlined,
            title: "Customer database",
            subtitle: "7 customers",
            onTap: () {
              AppHaptics.tap();
              Navigator.pushNamed(context, "/customerDatabaseScreen");
            },
          ),

          Divider(height: 1),

          _tile(
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "2 unread",
            onTap: () { AppHaptics.tap(); },
          ),

          Divider(height: 1),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                _icon(Icons.dark_mode_outlined),

                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Dark mode",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),

                      CustomSubText(
                        text: "Placeholder toggle",
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),

                Switch(
                  value: darkMode,
                  activeColor: AppColors.primary,
                  onChanged: (v) {
                    setState(() {
                      darkMode = v;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () { AppHaptics.tap(); onTap(); },
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            _icon(icon),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),

                  CustomSubText(text: subtitle, fontSize: 12.sp),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: Colors.grey, size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(icon, color: AppColors.labelGrey, size: 18.sp),
    );
  }

  //=========================================================
  // SWITCH VIEW
  //=========================================================

  Widget _buildSwitchView() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleText(text: "Switch view", fontSize: 16.sp),

          SizedBox(height: 12.h),

          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      AppHaptics.tap();
                      setState(() {
                        adminMode = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: !adminMode ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Employee",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      AppHaptics.tap();
                      setState(() {
                        adminMode = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: adminMode ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Admin",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=========================================================
  // LOGOUT
  //=========================================================

  Widget _buildLogout() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, color: Colors.red, size: 18.sp),

            SizedBox(width: 8.w),

            CustomText(
              text: "Log out",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
