import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/auth/auth_cubit.dart';
import '../../Cubits/auth/auth_state.dart';
import '../../Cubits/company/company_cubit.dart';
import '../../Cubits/company/company_state.dart';
import '../../Cubits/employee/employee_cubit.dart';
import '../../Cubits/employee/employee_state.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Widgets/custom_text.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().loadMyStats();
    context.read<CompanyCubit>().loadCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final user = authState.user;
        final name = user?['name'] as String? ?? 'User';
        final employeeId = user?['employeeId'] as String? ?? '';
        final phone = user?['phone'] as String? ?? '';
        final company = user?['company'] as String? ?? '';
        final initials = name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();

        return BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, empState) {
            final stats = empState.stats;
            final orders = stats?['orders']?.toString() ?? '0';
            final monthlyPieces = stats?['pieces']?.toString() ?? '0';
            final performance = stats?['performance']?.toString() ?? '0';

            return BlocBuilder<CompanyCubit, CompanyState>(
              builder: (context, compState) {
                final companies = compState.companies ?? [];
                final companyName = _companyName(company, companies);

                return Scaffold(
                  backgroundColor: AppColors.scaffoldBackground,
                  body: SafeArea(
                    child: ListView(
                      padding: EdgeInsets.all(16.r),
                      children: [
                        _buildTopBar(),
                        SizedBox(height: 20.h),
                        _buildHeaderCard(name, employeeId, phone, initials),
                        SizedBox(height: 16.h),
                        _buildStatsRow(orders, monthlyPieces, '$performance%'),
                        SizedBox(height: 16.h),
                        _buildCompanyRow(companyName),
                        SizedBox(height: 16.h),
                        _buildLogoutButton(context),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _companyName(String companyId, List<dynamic> companies) {
    if (companyId.isEmpty) return 'Company';
    for (final c in companies) {
      if (c is Map<String, dynamic> && c['_id'] == companyId) {
        return c['name'] as String? ?? 'Company';
      }
    }
    return companyId;
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r, backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        CustomTitleText(text: 'My profile', fontSize: 20.sp),
      ],
    );
  }

  Widget _buildHeaderCard(String name, String employeeId, String phone, String initials) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
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
                  border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
                ),
                child: CircleAvatar(
                  radius: 28.r, backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: CustomText(text: initials, fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleText(text: name, fontSize: 17.sp, color: Colors.white),
                    SizedBox(height: 2.h),
                    CustomSubText(text: employeeId, fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.75)),
                    SizedBox(height: 2.h),
                    CustomSubText(text: phone, fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.75)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(String orders, String monthlyPieces, String performance) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(orders, 'Orders')),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatCard(monthlyPieces, 'This month')),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatCard(performance, 'Score')),
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

  Widget _buildCompanyRow(String companyName) {
    final displayName = companyName.isNotEmpty ? companyName : 'Company';
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w, height: 44.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.activeBadgeBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CustomText(
              text: displayName.isNotEmpty ? displayName.substring(0, 1).toUpperCase() : '?',
              fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.activeBadgeText,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSubText(text: 'Company', fontSize: 13.sp),
                CustomTitleText(text: displayName, fontSize: 16.sp),
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

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          AppHaptics.tap();
          context.read<AuthCubit>().logout();
          Navigator.pushReplacementNamed(context, '/loginscreen');
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.card,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          side: const BorderSide(color: AppColors.borderGrey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
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
