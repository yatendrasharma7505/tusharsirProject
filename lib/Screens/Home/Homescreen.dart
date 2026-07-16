import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tusharsirproject/bottom_bar.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_routes.dart';
import '../../Widgets/custom_text.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: _buildTopBar(context),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
                children: [
                  _buildGreeting(),
                  SizedBox(height: 12.h),
                  _buildCompanyBanner(),
                  SizedBox(height: 12.h),
                  _buildStatsGrid(),
                  SizedBox(height: 12.h),
                  _buildDailyTargetCard(),
                  SizedBox(height: 14.h),
                  _buildQuickActionsRow(context),
                  SizedBox(height: 14.h),
                  _buildLeaderboardHeader(context),
                  SizedBox(height: 8.h),
                  _buildLeaderboardCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
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
            CustomTitleText(
              text: 'OrderDesk',
              fontSize: 16.sp,
            ),
            CustomSubText(
              text: 'Shree Textiles',
              fontSize: 11.sp,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.notification),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.fieldFill,
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                  size: 16.sp,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.logoutRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        CircleAvatar(
          radius: 16.r,
          backgroundColor: AppColors.fieldFill,
          child: Icon(
            Icons.wb_sunny_outlined,
            color: Colors.black87,
            size: 16.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSubText(
                text: 'Good afternoon,',
                fontSize: 12.sp,
              ),
              Row(
                children: [
                  CustomTitleText(
                    text: 'Rahul',
                    fontSize: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  CustomText(text: '👋', fontSize: 16.sp),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.primary,
          child: CustomText(text: 'RS', fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCompanyBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.business_outlined,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSubText(
                  text: "You're working under",
                  fontSize: 11.sp,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
                CustomTitleText(
                  text: 'Shree Textiles',
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: CustomText(
              text: 'ST',
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.shopping_bag_outlined,
                iconBackground: const Color(0xFFDCEDE9),
                iconColor: const Color(0xFF2E6C64),
                value: '2',
                label: 'Orders today',
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.tag,
                iconBackground: const Color(0xFFFBE6D8),
                iconColor: const Color(0xFFD2762E),
                value: '130',
                label: 'Pieces today',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_today_outlined,
                iconBackground: const Color(0xFFE3E1FB),
                iconColor: const Color(0xFF6C63D6),
                value: '812',
                label: 'This month',
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up,
                iconBackground: const Color(0xFFDCEDE9),
                iconColor: const Color(0xFF2E6C64),
                value: '96%',
                label: 'Perf. score',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: iconBackground,
            child: Icon(icon, size: 16.sp, color: iconColor),
          ),
          SizedBox(height: 8.h),
          CustomStatText(
            text: value,
            fontSize: 16.sp,
          ),
          SizedBox(height: 2.h),
          CustomSubText(
            text: label,
            fontSize: 11.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyTargetCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomTitleText(
                text: 'Team daily target',
                fontSize: 13.sp,
              ),
              const Spacer(),
              CustomStatText(
                text: '79%',
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: 0.79,
              minHeight: 8.h,
              backgroundColor: AppColors.fieldFill,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: 6.h),
          CustomSubText(
            text: '118 of 150 orders processed today',
            fontSize: 11.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            background: const Color(0xFFEFFBF4),
            border: const Color(0xFFBFE6D1),
            iconBackground: const Color(0xFF3FAE5C),
            icon: Icons.chat_bubble_outline,
            title: 'Import from WhatsApp',
            subtitle: 'Shared photo + text',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/addOrderManualscreen"),

            child: _buildActionCard(
              background: const Color(0xFFF4F9F7),
              border: const Color(0xFFDCEEE4),
              iconBackground: AppColors.primary,
              icon: Icons.add,
              title: 'Add manual order',
              subtitle: 'Type it in yourself',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required Color background,
    required Color border,
    required Color iconBackground,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor: iconBackground,
            child: Icon(icon, color: Colors.white, size: 16.sp),
          ),
          SizedBox(height: 8.h),
          CustomTitleText(
            text: title,
            fontSize: 12.sp,
          ),
          SizedBox(height: 2.h),
          CustomSubText(
            text: subtitle,
            fontSize: 10.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardHeader(BuildContext context) {
    return Row(
      children: [
        CustomTitleText(
          text: "Today's leaderboard",
          fontSize: 14.sp,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomBar(index: 2)),
          ),
          child: Row(
            children: [
              CustomText(
                text: 'See all',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              Icon(Icons.chevron_right, size: 16.sp, color: AppColors.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          _buildLeaderboardRow(
            rank: 1,
            rankBackground: const Color(0xFFF6EAC9),
            rankColor: const Color(0xFFB8860B),
            avatarBackground: AppColors.primary,
            initials: 'RS',
            name: 'Rahul Sharma',
            subtitle: '42 orders · 310 pcs',
            showCrown: true,
          ),
          Divider(color: AppColors.borderGrey, height: 18.h),
          _buildLeaderboardRow(
            rank: 2,
            rankBackground: AppColors.fieldFill,
            rankColor: AppColors.labelGrey,
            avatarBackground: const Color(0xFFD98C3D),
            initials: 'AV',
            name: 'Amit Verma',
            subtitle: '35 orders · 220 pcs',
          ),
          Divider(color: AppColors.borderGrey, height: 18.h),
          _buildLeaderboardRow(
            rank: 3,
            rankBackground: const Color(0xFFF7E4C9),
            rankColor: const Color(0xFFAD7A32),
            avatarBackground: const Color(0xFF6C63D6),
            initials: 'PS',
            name: 'Priya Singh',
            subtitle: '30 orders · 190 pcs',
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required int rank,
    required Color rankBackground,
    required Color rankColor,
    required Color avatarBackground,
    required String initials,
    required String name,
    required String subtitle,
    bool showCrown = false,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.r,
          backgroundColor: rankBackground,
          child: CustomText(
            text: '$rank',
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: rankColor,
          ),
        ),
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 16.r,
          backgroundColor: avatarBackground,
          child: CustomText(
            text: initials,
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              CustomSubText(
                text: subtitle,
                fontSize: 11.sp,
              ),
            ],
          ),
        ),
        if (showCrown) Icon(Icons.emoji_events, color: Colors.amber, size: 18.sp),
      ],
    );
  }
}
