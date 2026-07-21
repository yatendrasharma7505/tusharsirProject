import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tusharsirproject/bottom_bar.dart';
import '../../Cubits/auth/auth_cubit.dart';
import '../../Cubits/auth/auth_state.dart';
import '../../Cubits/dashboard/dashboard_cubit.dart';
import '../../Cubits/dashboard/dashboard_state.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Utils/app_routes.dart';
import '../../Widgets/custom_text.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final user = authState.user;
        final name = user?['name'] as String? ?? 'User';
        final initials = name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();
        final greeting = _getGreeting();

        return BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, dashState) {
            final company = dashState.data?['company'] as Map<String, dynamic>?;
            final companyName = company?['name'] as String? ?? 'Company';
            final stats = dashState.data?['stats'] as Map<String, dynamic>?;
            final target = dashState.data?['teamDailyTarget'] as Map<String, dynamic>?;
            final top3 = dashState.data?['leaderboardTop3'] as List<dynamic>?;

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
                          _buildGreeting(greeting, name, initials),
                          SizedBox(height: 12.h),
                          _buildCompanyBanner(companyName),
                          SizedBox(height: 12.h),
                          _buildStatsGrid(stats),
                          SizedBox(height: 12.h),
                          if (target != null) _buildDailyTargetCard(target),
                          SizedBox(height: 14.h),
                          _buildQuickActionsRow(context),
                          SizedBox(height: 14.h),
                          if (top3 != null && top3.isNotEmpty)
                            _buildLeaderboard(context, top3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
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
            CustomTitleText(text: 'OrderDesk', fontSize: 16.sp),
            CustomSubText(text: 'Shree Textiles', fontSize: 11.sp),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () { AppHaptics.tap(); Navigator.pushNamed(context, AppRoutes.notification); },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.fieldFill,
                child: Icon(Icons.notifications_none, color: Colors.black87, size: 16.sp),
              ),
              Positioned(
                top: 0, right: 0,
                child: Container(
                  width: 8.w, height: 8.w,
                  decoration: const BoxDecoration(color: AppColors.logoutRed, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        CircleAvatar(
          radius: 16.r,
          backgroundColor: AppColors.fieldFill,
          child: Icon(Icons.wb_sunny_outlined, color: Colors.black87, size: 16.sp),
        ),
      ],
    );
  }

  Widget _buildGreeting(String greeting, String name, String initials) {
    final firstName = name.split(' ').first;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSubText(text: '$greeting,', fontSize: 12.sp),
              Row(
                children: [
                  CustomTitleText(text: firstName, fontSize: 16.sp),
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
          child: CustomText(text: initials, fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCompanyBanner(String company) {
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
            width: 38.w, height: 38.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.business_outlined, color: Colors.white, size: 18.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSubText(text: "You're working under", fontSize: 11.sp, color: Colors.white.withValues(alpha: 0.75)),
                CustomTitleText(text: company, fontSize: 14.sp, color: Colors.white),
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
              text: company.length >= 2 ? company.substring(0, 2).toUpperCase() : company.substring(0, 1).toUpperCase(),
              fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic>? stats) {
    final ordersToday = stats?['ordersToday']?.toString() ?? '0';
    final piecesToday = stats?['piecesToday']?.toString() ?? '0';
    final monthlyPieces = stats?['monthlyPieces']?.toString() ?? '0';
    final performance = stats?['performance']?.toString() ?? '0';
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard(
              icon: Icons.shopping_bag_outlined,
              iconBackground: const Color(0xFFDCEDE9),
              iconColor: const Color(0xFF2E6C64),
              value: ordersToday,
              label: 'Orders today',
            )),
            SizedBox(width: 10.w),
            Expanded(child: _buildStatCard(
              icon: Icons.tag,
              iconBackground: const Color(0xFFFBE6D8),
              iconColor: const Color(0xFFD2762E),
              value: piecesToday,
              label: 'Pieces today',
            )),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(child: _buildStatCard(
              icon: Icons.calendar_today_outlined,
              iconBackground: const Color(0xFFE3E1FB),
              iconColor: const Color(0xFF6C63D6),
              value: monthlyPieces,
              label: 'This month',
            )),
            SizedBox(width: 10.w),
            Expanded(child: _buildStatCard(
              icon: Icons.trending_up,
              iconBackground: const Color(0xFFDCEDE9),
              iconColor: const Color(0xFF2E6C64),
              value: '$performance%',
              label: 'Perf. score',
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon, required Color iconBackground, required Color iconColor,
    required String value, required String label,
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
            radius: 14.r, backgroundColor: iconBackground,
            child: Icon(icon, size: 16.sp, color: iconColor),
          ),
          SizedBox(height: 8.h),
          CustomStatText(text: value, fontSize: 16.sp),
          SizedBox(height: 2.h),
          CustomSubText(text: label, fontSize: 11.sp),
        ],
      ),
    );
  }

  Widget _buildDailyTargetCard(Map<String, dynamic> target) {
    final achieved = target['achieved'] ?? 0;
    final targetVal = target['target'] ?? 0;
    final progress = target['progressPercent'] ?? 0;
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
              CustomTitleText(text: 'Team daily target', fontSize: 13.sp),
              const Spacer(),
              CustomStatText(text: '$progress%', fontSize: 14.sp, color: AppColors.primary),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: (progress as num).toDouble() / 100,
              minHeight: 8.h,
              backgroundColor: AppColors.fieldFill,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: 6.h),
          CustomSubText(text: '$achieved of $targetVal orders processed today', fontSize: 11.sp),
        ],
      ),
    );
  }

  Widget _buildQuickActionsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildActionCard(
          background: const Color(0xFFEFFBF4), border: const Color(0xFFBFE6D1),
          iconBackground: const Color(0xFF3FAE5C), icon: Icons.chat_bubble_outline,
          title: 'Import from WhatsApp', subtitle: 'Shared photo + text',
        )),
        SizedBox(width: 10.w),
        Expanded(
          child: GestureDetector(
            onTap: () { AppHaptics.tap(); Navigator.pushNamed(context, "/addOrderManualscreen"); },
            child: _buildActionCard(
              background: const Color(0xFFF4F9F7), border: const Color(0xFFDCEEE4),
              iconBackground: AppColors.primary, icon: Icons.add,
              title: 'Add manual order', subtitle: 'Type it in yourself',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required Color background, required Color border, required Color iconBackground,
    required IconData icon, required String title, required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: background, borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16.r, backgroundColor: iconBackground,
            child: Icon(icon, color: Colors.white, size: 16.sp),
          ),
          SizedBox(height: 8.h),
          CustomTitleText(text: title, fontSize: 12.sp),
          SizedBox(height: 2.h),
          CustomSubText(text: subtitle, fontSize: 10.sp),
        ],
      ),
    );
  }

  Widget _buildLeaderboard(BuildContext context, List<dynamic> top3) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomTitleText(text: "Today's leaderboard", fontSize: 14.sp),
            const Spacer(),
            GestureDetector(
              onTap: () { AppHaptics.tap(); Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomBar(index: 2)),
              ); },
              child: Row(
                children: [
                  CustomText(text: 'See all', fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.primary),
                  Icon(Icons.chevron_right, size: 16.sp, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            children: top3.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value as Map<String, dynamic>;
              final user = item['user'] as Map<String, dynamic>?;
              final userName = user?['name'] as String? ?? 'User';
              final userInitials = userName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();
              final orders = item['orders'] ?? 0;
              final pieces = item['pieces'] ?? 0;
              return Column(
                children: [
                  _buildLeaderboardRow(
                    rank: i + 1,
                    rankBackground: i == 0 ? const Color(0xFFF6EAC9) : AppColors.fieldFill,
                    rankColor: i == 0 ? const Color(0xFFB8860B) : AppColors.labelGrey,
                    avatarBackground: i == 0 ? AppColors.primary : const Color(0xFFD98C3D),
                    initials: userInitials,
                    name: userName,
                    subtitle: '$orders orders · $pieces pcs',
                    showCrown: i == 0,
                  ),
                  if (i < top3.length - 1) Divider(color: AppColors.borderGrey, height: 18.h),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardRow({
    required int rank, required Color rankBackground, required Color rankColor,
    required Color avatarBackground, required String initials,
    required String name, required String subtitle, bool showCrown = false,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.r, backgroundColor: rankBackground,
          child: CustomText(text: '$rank', fontSize: 11.sp, fontWeight: FontWeight.bold, color: rankColor),
        ),
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 16.r, backgroundColor: avatarBackground,
          child: CustomText(text: initials, fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: name, fontSize: 13.sp, fontWeight: FontWeight.w600),
              CustomSubText(text: subtitle, fontSize: 11.sp),
            ],
          ),
        ),
        if (showCrown) Icon(Icons.emoji_events, color: Colors.amber, size: 18.sp),
      ],
    );
  }
}
