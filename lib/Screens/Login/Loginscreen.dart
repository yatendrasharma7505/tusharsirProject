import 'package:dio/dio.dart';
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

/// The employee app never lets an admin choose a password for someone else.
/// After the Employee ID/phone step, [_LoginStep.setPassword] is shown the
/// first time an admin-created account signs in, so the employee sets their
/// own password (with a confirm field) before they can use the app.
enum _LoginStep { identifier, signIn, setPassword }

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  _LoginStep _step = _LoginStep.identifier;
  bool _checking = false;
  String? _checkError;
  String? _employeeName;

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
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final identifier = _idController.text.trim();
    if (identifier.isEmpty) {
      setState(() => _checkError = 'Enter your Employee ID or phone');
      return;
    }

    AppHaptics.tap();
    setState(() {
      _checking = true;
      _checkError = null;
    });

    try {
      final result = await context.read<AuthCubit>().checkIdentifier(identifier);
      setState(() {
        _employeeName = result['name'] as String?;
        _step = (result['needsPasswordSetup'] == true) ? _LoginStep.setPassword : _LoginStep.signIn;
      });
    } catch (e) {
      setState(() => _checkError = _parseError(e));
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  void _resetToIdentifier() {
    setState(() {
      _step = _LoginStep.identifier;
      _passwordController.clear();
      _confirmPasswordController.clear();
      _checkError = null;
      _employeeName = null;
    });
  }

  String _parseError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
      return 'Connection failed. Check your network.';
    }
    return e.toString();
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
                text: _step == _LoginStep.setPassword ? 'Set your password' : 'Welcome back',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 6.h),
              CustomSubText(text: _subtitle(), fontSize: 14.sp),
              SizedBox(height: 32.h),
              if (_step == _LoginStep.identifier) ..._buildIdentifierFields(),
              if (_step != _LoginStep.identifier) ..._buildIdentifierSummary(),
              if (_step == _LoginStep.signIn) ..._buildSignInFields(),
              if (_step == _LoginStep.setPassword) ..._buildSetPasswordFields(),
              SizedBox(height: 32.h),
              _buildAction(),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle() {
    switch (_step) {
      case _LoginStep.identifier:
        return 'Sign in to your account';
      case _LoginStep.signIn:
        return _employeeName != null ? 'Hi $_employeeName, enter your password' : 'Enter your password';
      case _LoginStep.setPassword:
        return 'First time here — choose a password for your account';
    }
  }

  List<Widget> _buildIdentifierFields() {
    return [
      CustomTextField(
        icon: Icons.person_outline_rounded,
        label: 'Employee ID or phone',
        controller: _idController,
      ),
    ];
  }

  List<Widget> _buildIdentifierSummary() {
    return [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(Icons.person_outline_rounded, size: 18.sp, color: AppColors.labelGrey),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomText(
                text: _idController.text.trim(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: _resetToIdentifier,
              child: CustomText(
                text: 'Change',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20.h),
    ];
  }

  List<Widget> _buildSignInFields() {
    return [
      CustomTextField(
        icon: Icons.lock_outline_rounded,
        label: 'Password',
        controller: _passwordController,
        obscureText: true,
      ),
    ];
  }

  List<Widget> _buildSetPasswordFields() {
    return [
      CustomTextField(
        icon: Icons.lock_outline_rounded,
        label: 'New password',
        controller: _passwordController,
        obscureText: true,
      ),
      SizedBox(height: 20.h),
      CustomTextField(
        icon: Icons.lock_outline_rounded,
        label: 'Confirm password',
        controller: _confirmPasswordController,
        obscureText: true,
      ),
    ];
  }

  Widget _buildAction() {
    if (_step == _LoginStep.identifier) {
      return Column(
        children: [
          CustomButton(
            label: _checking ? 'Checking...' : 'Continue',
            trailingIcon: Icons.arrow_forward_rounded,
            enabled: !_checking,
            onPressed: _continue,
          ),
          if (_checkError != null)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: CustomText(text: _checkError!, fontSize: 13.sp, color: AppColors.logoutRed),
            ),
        ],
      );
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacementNamed(context, "/bottombar");
        }
      },
      builder: (context, state) {
        final loading = state.status == AuthStatus.loading;
        final isSetPassword = _step == _LoginStep.setPassword;
        return Column(
          children: [
            CustomButton(
              label: loading
                  ? (isSetPassword ? 'Setting password...' : 'Signing in...')
                  : (isSetPassword ? 'Set password & sign in' : 'Sign in'),
              trailingIcon: Icons.arrow_forward_rounded,
              enabled: !loading,
              onPressed: () {
                AppHaptics.tap();
                final identifier = _idController.text.trim();
                if (isSetPassword) {
                  final password = _passwordController.text;
                  final confirmPassword = _confirmPasswordController.text;
                  if (password.length < 6) {
                    _showFieldError('Password must be at least 6 characters');
                    return;
                  }
                  if (password != confirmPassword) {
                    _showFieldError('Passwords do not match');
                    return;
                  }
                  context.read<AuthCubit>().setPassword(identifier, password, confirmPassword);
                } else {
                  context.read<AuthCubit>().login(identifier, _passwordController.text);
                }
              },
            ),
            if (state.status == AuthStatus.error)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CustomText(
                  text: state.errorMessage ?? 'Something went wrong',
                  fontSize: 13.sp,
                  color: AppColors.logoutRed,
                ),
              ),
          ],
        );
      },
    );
  }

  void _showFieldError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.logoutRed),
    );
  }
}
