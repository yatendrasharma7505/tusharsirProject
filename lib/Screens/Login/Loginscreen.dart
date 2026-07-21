import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/auth/auth_cubit.dart';
import '../../Cubits/auth/auth_state.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/custom_text_field.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().checkAuth();
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacementNamed(context, "/bottombar");
        }
      },
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    Navigator.pushReplacementNamed(context, "/bottombar");
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomButton(
                        label: state.status == AuthStatus.loading ? 'Signing in...' : 'Sign in',
                        trailingIcon: Icons.arrow_forward_rounded,
                        enabled: state.status != AuthStatus.loading,
                        onPressed: () {
                          AppHaptics.tap();
                          context.read<AuthCubit>().login(
                            _idController.text.trim(),
                            _passwordController.text,
                          );
                        },
                      ),
                      if (state.status == AuthStatus.error)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: CustomText(
                            text: state.errorMessage ?? 'Login failed',
                            fontSize: 13.sp,
                            color: AppColors.logoutRed,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
