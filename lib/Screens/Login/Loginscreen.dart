import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Utils/app_haptics.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // _buildHeader(),
            Expanded(child: Center(child: _buildLoginCard())),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderGrey,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              CustomText(
                text: 'Welcome back',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 6.h),
              CustomSubText(text: 'Sign in to your account', fontSize: 14.sp),
              SizedBox(height: 32.h),
              CustomTextField(
                icon: Icons.person_outline_rounded,
                label: 'Employee ID or phone',
                // hint: 'E01 or +91...',
                controller: _idController,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                icon: Icons.lock_outline_rounded,
                label: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 32.h),
              CustomButton(
                label: 'Sign in',
                trailingIcon: Icons.arrow_forward_rounded,
                onPressed: () {
                  AppHaptics.tap();
                  Navigator.pushNamed(context, "/bottombar");
                },
              ),
              SizedBox(height: 28.h),
              // _buildDemoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoSection() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.borderGrey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CustomText(
                text: 'DEMO ACCESS',
                fontSize: 11.sp,
                color: AppColors.hintGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Expanded(child: Divider(color: AppColors.borderGrey)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                filled: false,
                leadingIcon: Icons.person_outline_rounded,
                leadingIconColor: Colors.black54,
                label: 'Employee',
                onPressed: () {
                  AppHaptics.tap();
                  Navigator.pushNamed(context, "/bottombar");
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomButton(
                filled: false,
                leadingIcon: Icons.emoji_events_outlined,
                leadingIconColor: Colors.orange,
                label: 'Admin',
                onPressed: () {
                  AppHaptics.tap();
                  Navigator.pushNamed(context, "/adminbottombar");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
