import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/leaderboard/leaderboard_cubit.dart';
import '../../Cubits/leaderboard/leaderboard_state.dart';
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
  static const List<String> _ranges = ['day', 'week', 'month'];

  @override
  void initState() {
    super.initState();
    context.read<LeaderboardCubit>().loadLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final entries = state.leaderboard ?? [];
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
                if (entries.length >= 3) _buildPodium(entries),
                SizedBox(height: 24.h),
                if (entries.isNotEmpty) _buildLeaderboardList(entries),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r, backgroundColor: AppColors.primary,
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
                radius: 20.r, backgroundColor: AppColors.fieldFill,
                child: Icon(Icons.notifications_none, color: Colors.black87, size: 19.sp),
              ),
              Positioned(
                top: 2.h, right: 2.w,
                child: Container(
                  width: 9.w, height: 9.w,
                  decoration: const BoxDecoration(color: AppColors.logoutRed, shape: BoxShape.circle),
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
              onTap: () {
                AppHaptics.tap();
                setState(() => _selectedFilter = index);
                context.read<LeaderboardCubit>().loadLeaderboard(range: _ranges[index]);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(26.r),
                  boxShadow: selected ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6.r, offset: Offset(0, 2.h))] : null,
                ),
                child: CustomText(text: _filters[index], textAlign: TextAlign.center, fontSize: 14.sp, fontWeight: FontWeight.w600, color: selected ? Colors.black87 : AppColors.hintGrey),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPodium(List<dynamic> entries) {
    final top3 = entries.take(3).toList();
    final second = top3.length > 1 ? top3[1] as Map<String, dynamic> : null;
    final first = top3.isNotEmpty ? top3[0] as Map<String, dynamic> : null;
    final third = top3.length > 2 ? top3[2] as Map<String, dynamic> : null;

    final sUser = second?['user'] as Map<String, dynamic>?;
    final fUser = first?['user'] as Map<String, dynamic>?;
    final tUser = third?['user'] as Map<String, dynamic>?;

    const double baseHeight = 130;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (second != null) _buildPodiumBar(
          rankLabel: '2',
          height: baseHeight / 1.5,
          title: _buildPodiumTitle(
            ringColor: AppColors.hintGrey,
            avatarColor: const Color(0xFFD98C3D),
            initials: _initials(sUser?['name'] as String? ?? ''),
            name: _firstName(sUser?['name'] as String? ?? ''),
            score: '${second['orders'] ?? 0}',
          ),
        ),
        SizedBox(width: 8.w),
        if (first != null) _buildPodiumBar(
          rankLabel: '1',
          height: baseHeight,
          title: _buildPodiumTitle(
            ringColor: const Color(0xFFE8B84B),
            avatarColor: AppColors.primary,
            initials: _initials(fUser?['name'] as String? ?? ''),
            name: _firstName(fUser?['name'] as String? ?? ''),
            score: '${first['orders'] ?? 0}',
            showCrown: true,
          ),
        ),
        SizedBox(width: 8.w),
        if (third != null) _buildPodiumBar(
          rankLabel: '3',
          height: baseHeight / 2.5,
          title: _buildPodiumTitle(
            ringColor: const Color(0xFFAD7A32),
            avatarColor: const Color(0xFF6C63D6),
            initials: _initials(tUser?['name'] as String? ?? ''),
            name: _firstName(tUser?['name'] as String? ?? ''),
            score: '${third['orders'] ?? 0}',
          ),
        ),
      ],
    );
  }

  Widget _buildPodiumBar({required String rankLabel, required double height, required Widget title}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 90.w, child: Center(child: title)),
        SizedBox(height: 10.h),
        Container(
          width: 90.w, height: height.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          ),
          child: CustomText(text: rankLabel, fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPodiumTitle({
    required Color ringColor, required Color avatarColor,
    required String initials, required String name,
    required String score, bool showCrown = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showCrown) Icon(Icons.emoji_events, color: const Color(0xFFE8B84B), size: 22.sp) else SizedBox(height: 22.sp),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ringColor, width: 2)),
          child: CircleAvatar(
            radius: 26.r, backgroundColor: avatarColor,
            child: CustomText(text: initials, fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 8.h),
        CustomText(text: name, fontSize: 14.sp, fontWeight: FontWeight.w600),
        CustomText(text: score, fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ],
    );
  }

  Widget _buildLeaderboardList(List<dynamic> entries) {
    final maxOrders = entries.isNotEmpty ? (entries[0] as Map<String, dynamic>)['orders'] as num? ?? 1 : 1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: entries.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value as Map<String, dynamic>;
          final user = item['user'] as Map<String, dynamic>?;
          final userName = user?['name'] as String? ?? 'User';
          final orders = item['orders'] as num? ?? 0;
          final pieces = item['pieces'] as num? ?? 0;
          return Column(
            children: [
              _buildLeaderboardRow(
                rank: i + 1,
                rankBackground: i == 0 ? const Color(0xFFF6EAC9) : AppColors.fieldFill,
                rankColor: i == 0 ? const Color(0xFFB8860B) : AppColors.labelGrey,
                avatarColor: i == 0 ? AppColors.primary : const Color(0xFFD98C3D),
                initials: _initials(userName),
                name: userName,
                score: orders.toInt(),
                pieces: pieces.toInt(),
                progress: maxOrders > 0 ? orders.toDouble() / maxOrders.toDouble() : 0,
                progressColor: i == 0 ? const Color(0xFFE8A548) : AppColors.primary,
                showTopBadge: i == 0,
              ),
              if (i < entries.length - 1) Divider(color: AppColors.borderGrey, height: 24.h),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required int rank, required Color rankBackground, required Color rankColor,
    required Color avatarColor, required String initials, required String name,
    required int score, required int pieces,
    required double progress, required Color progressColor, bool showTopBadge = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 14.r, backgroundColor: rankBackground,
          child: CustomText(text: '$rank', fontSize: 13.sp, fontWeight: FontWeight.bold, color: rankColor),
        ),
        SizedBox(width: 12.w),
        CircleAvatar(
          radius: 18.r, backgroundColor: avatarColor,
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
                  value: progress, minHeight: 6.h,
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

  String _initials(String name) {
    return name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();
  }

  String _firstName(String name) {
    return name.split(' ').first;
  }
}
