import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Widgets/custom_text.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  bool _isEmployeeView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            _buildTopBar(),
            SizedBox(height: 20.h),
            _buildHeaderCard(),
            SizedBox(height: 16.h),
            _buildStatsRow(),
            SizedBox(height: 16.h),
            _buildCompanyRow(),
            SizedBox(height: 16.h),
            _buildViewAsCard(),
            SizedBox(height: 16.h),
            _buildLogoutButton(),
          ],
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
        SizedBox(width: 12.w),
        CustomTitleText(text: 'My profile', fontSize: 20.sp),
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.fieldFill,
              child: Icon(
                Icons.notifications_none,
                color: Colors.black87,
                size: 20.sp,
              ),
            ),
            Positioned(
              top: 2.h,
              right: 2.w,
              child: Container(
                width: 9.w,
                height: 9.w,
                decoration: const BoxDecoration(
                  color: AppColors.logoutRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.background],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: CustomText(text: 'RS', fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleText(text: 'Rahul Sharma', fontSize: 17.sp, color: Colors.white),
                    SizedBox(height: 2.h),
                    CustomSubText(text: 'Senior Packer · E01', fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.75)),
                    SizedBox(height: 2.h),
                    CustomSubText(text: '+91 98110 23401', fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.75)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                CustomText(text: 'Shree Textiles', fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('382', 'Orders')),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatCard('812', 'This month')),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatCard('96%', 'Score')),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          CustomStatText(text: value, fontSize: 18.sp),
          SizedBox(height: 4.h),
          CustomSubText(text: label, fontSize: 12.sp),
        ],
      ),
    );
  }

  Widget _buildCompanyRow() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.activeBadgeBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CustomText(text: 'ST', fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.activeBadgeText),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSubText(text: 'Company', fontSize: 13.sp),
                CustomTitleText(text: 'Shree Textiles', fontSize: 16.sp),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.activeBadgeBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: CustomText(text: 'Active', fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.activeBadgeText),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAsCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleText(text: 'View the app as', fontSize: 15.sp),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildViewAsOption(
                    icon: Icons.person_outline,
                    label: 'Employee',
                    selected: _isEmployeeView,
                    onTap: () { AppHaptics.tap(); setState(() => _isEmployeeView = true); },
                  ),
                ),
                Expanded(
                  child: _buildViewAsOption(
                    icon: Icons.emoji_events_outlined,
                    label: 'Admin',
                    selected: !_isEmployeeView,
                    onTap: () { AppHaptics.tap(); setState(() => _isEmployeeView = false); },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAsOption({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () { AppHaptics.tap(); onTap(); },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(26.r),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6.r,
                    offset: Offset(0, 2.h),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: selected ? Colors.black87 : AppColors.hintGrey,
            ),
            SizedBox(width: 6.w),
            CustomText(text: label, fontSize: 14.sp, fontWeight: FontWeight.w600, color: selected ? Colors.black87 : AppColors.hintGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () { AppHaptics.tap(); },
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.card,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          side: const BorderSide(color: AppColors.borderGrey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: AppColors.logoutRed, size: 18.sp),
            SizedBox(width: 8.w),
            CustomText(text: 'Log out', fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColors.logoutRed),
          ],
        ),
      ),
    );
  }
}
