import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Utils/app_routes.dart';
import '../../Widgets/custom_text.dart';

class Rankscreen extends StatefulWidget {
  const Rankscreen({super.key});

  @override
  State<Rankscreen> createState() => _RankscreenState();
}

class _RankscreenState extends State<Rankscreen> {
  int _selectedFilter = 0;

  static const List<String> _filters = ['Today', 'Week', 'Month'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            _buildTopBar(context),
            SizedBox(height: 16.h),
            _buildFilterTabs(),
            SizedBox(height: 24.h),
            _buildPodium(),
            SizedBox(height: 24.h),
            _buildLeaderboardCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(text: 'Leaderboard', fontSize: 19.sp),
            CustomSubText(text: "Who's winning today", fontSize: 13.sp),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () { AppHaptics.tap(); Navigator.pushNamed(context, AppRoutes.notification); },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.fieldFill,
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                  size: 19.sp,
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
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final bool selected = _selectedFilter == index;
          return Expanded(
            child: GestureDetector(
              onTap: () { AppHaptics.tap(); setState(() => _selectedFilter = index); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
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
                child: CustomText(text: _filters[index], textAlign: TextAlign.center, fontSize: 14.sp, fontWeight: FontWeight.w600, color: selected ? Colors.black87 : AppColors.hintGrey),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPodium() {
    const double baseHeight = 130;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPodiumBar(
          rankLabel: '2',
          height: baseHeight / 1.5,
          title: _buildPodiumTitle(
            ringColor: AppColors.hintGrey,
            avatarColor: const Color(0xFFD98C3D),
            initials: 'AV',
            name: 'Amit',
            score: '35',
          ),
        ),
        SizedBox(width: 8.w),
        _buildPodiumBar(
          rankLabel: '1',
          height: baseHeight,
          title: _buildPodiumTitle(
            ringColor: const Color(0xFFE8B84B),
            avatarColor: AppColors.primary,
            initials: 'RS',
            name: 'Rahul',
            score: '42',
            showCrown: true,
          ),
        ),
        SizedBox(width: 8.w),
        _buildPodiumBar(
          rankLabel: '3',
          height: baseHeight / 2.5,
          title: _buildPodiumTitle(
            ringColor: const Color(0xFFAD7A32),
            avatarColor: const Color(0xFF6C63D6),
            initials: 'PS',
            name: 'Priya',
            score: '30',
          ),
        ),
      ],
    );
  }

  Widget _buildPodiumBar({
    required String rankLabel,
    required double height,
    required Widget title,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 90.w, child: Center(child: title)),
        SizedBox(height: 10.h),
        Container(
          width: 90.w,
          height: height.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: CustomText(text: rankLabel, fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPodiumTitle({
    required Color ringColor,
    required Color avatarColor,
    required String initials,
    required String name,
    required String score,
    bool showCrown = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showCrown)
          Icon(Icons.emoji_events, color: const Color(0xFFE8B84B), size: 22.sp)
        else
          SizedBox(height: 22.sp),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ringColor, width: 2),
          ),
          child: CircleAvatar(
            radius: 26.r,
            backgroundColor: avatarColor,
            child: CustomText(text: initials, fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 8.h),
        CustomText(text: name, fontSize: 14.sp, fontWeight: FontWeight.w600),
        CustomText(text: score, fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ],
    );
  }

  Widget _buildLeaderboardCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildLeaderboardRow(
            rank: 1,
            rankBackground: const Color(0xFFF6EAC9),
            rankColor: const Color(0xFFB8860B),
            avatarColor: AppColors.primary,
            initials: 'RS',
            name: 'Rahul Sharma',
            score: 42,
            pieces: 310,
            progress: 1,
            progressColor: const Color(0xFFE8A548),
            showTopBadge: true,
          ),
          Divider(color: AppColors.borderGrey, height: 24.h),
          _buildLeaderboardRow(
            rank: 2,
            rankBackground: AppColors.fieldFill,
            rankColor: AppColors.labelGrey,
            avatarColor: const Color(0xFFD98C3D),
            initials: 'AV',
            name: 'Amit Verma',
            score: 35,
            pieces: 220,
            progress: 35 / 42,
            progressColor: AppColors.primary,
          ),
          Divider(color: AppColors.borderGrey, height: 24.h),
          _buildLeaderboardRow(
            rank: 3,
            rankBackground: const Color(0xFFF7E4C9),
            rankColor: const Color(0xFFAD7A32),
            avatarColor: const Color(0xFF6C63D6),
            initials: 'PS',
            name: 'Priya Singh',
            score: 30,
            pieces: 190,
            progress: 30 / 42,
            progressColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required int rank,
    required Color rankBackground,
    required Color rankColor,
    required Color avatarColor,
    required String initials,
    required String name,
    required int score,
    required int pieces,
    required double progress,
    required Color progressColor,
    bool showTopBadge = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 14.r,
          backgroundColor: rankBackground,
          child: CustomText(text: '$rank', fontSize: 13.sp, fontWeight: FontWeight.bold, color: rankColor),
        ),
        SizedBox(width: 12.w),
        CircleAvatar(
          radius: 18.r,
          backgroundColor: avatarColor,
          child: CustomText(text: initials, fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomText(text: name, overflow: TextOverflow.ellipsis, fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  if (showTopBadge) ...[SizedBox(width: 8.w), _buildTopBadge()],
                ],
              ),
              SizedBox(height: 6.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6.h,
                  backgroundColor: AppColors.fieldFill,
                  valueColor: AlwaysStoppedAnimation(progressColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomStatText(text: '$score', fontSize: 16.sp),
            CustomSubText(text: '$pieces pcs', fontSize: 12.sp),
          ],
        ),
      ],
    );
  }

  Widget _buildTopBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE8D6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 11.sp, color: const Color(0xFFE0973D)),
          SizedBox(width: 3.w),
          CustomText(text: 'TOP', fontSize: 10.sp, fontWeight: FontWeight.bold, color: const Color(0xFFE0973D)),
        ],
      ),
    );
  }
}
