import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Model/company_model.dart';
import '../../Utils/app_colors.dart';
import '../../Widgets/company_tile.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text_field.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final List<CompanyModel> _companies = CompanyModel.sampleCompanies;
  int _selectedCompanyIndex = 0;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                    child: _buildTabBar(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildFormTab(isSignIn: true),
                        _buildFormTab(isSignIn: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        labelColor: Colors.black87,
        unselectedLabelColor: AppColors.hintGrey,
        labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Sign in'),
          Tab(text: 'Register'),
        ],
      ),
    );
  }

  Widget _buildFormTab({required bool isSignIn}) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isSignIn) ..._buildSignInFields() else ..._buildRegisterFields(),
          SizedBox(height: 20.h),
          _buildSectionLabel(
            Icons.business_outlined,
            isSignIn ? 'Your company' : 'Register under company',
          ),
          SizedBox(height: 8.h),
          ...List.generate(
            _companies.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: CompanyTile(
                company: _companies[index],
                selected: _selectedCompanyIndex == index,
                onTap: () => setState(() => _selectedCompanyIndex = index),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          CustomButton(
            label: isSignIn ? 'Sign in' : 'Create account',
            trailingIcon: Icons.arrow_forward,
            onPressed: () {
              Navigator.pushNamed(context, "/bottombar");
            },
          ),
          SizedBox(height: 20.h),
          _buildDemoDivider(),
          SizedBox(height: 16.h),
          _buildDemoButtons(),
        ],
      ),
    );
  }

  List<Widget> _buildSignInFields() {
    return [
      CustomTextField(
        icon: Icons.person_outline,
        label: 'Employee ID or phone',
        hint: 'E01 or +91...',
        controller: _idController,
      ),
      SizedBox(height: 20.h),
      CustomTextField(
        icon: Icons.tag,
        label: 'Password / OTP',
        controller: _passwordController,
        obscureText: true,
      ),
    ];
  }

  List<Widget> _buildRegisterFields() {
    return [
      CustomTextField(
        icon: Icons.person_outline,
        label: 'Full name',
        hint: 'e.g. Rahul Sharma',
        controller: _fullNameController,
      ),
      SizedBox(height: 20.h),
      CustomTextField(
        icon: Icons.phone_outlined,
        label: 'Phone number',
        hint: '+91...',
        controller: _phoneController,
        keyboardType: TextInputType.phone,
      ),
      SizedBox(height: 20.h),
      CustomTextField(
        icon: Icons.tag,
        label: 'Password / OTP',
        controller: _passwordController,
        obscureText: true,
      ),
    ];
  }

  Widget _buildSectionLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppColors.labelGrey),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.labelGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDemoDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderGrey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'DEMO ACCESS',
            style: TextStyle(
              fontSize: 12.sp,
              letterSpacing: 1,
              color: AppColors.hintGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.borderGrey)),
      ],
    );
  }

  Widget _buildDemoButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            filled: false,
            leadingIcon: Icons.person_outline,
            leadingIconColor: Colors.black54,
            label: 'Employee',
            onPressed: () {},
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomButton(
            filled: false,
            leadingIcon: Icons.emoji_events_outlined,
            leadingIconColor: Colors.orange,
            label: 'Admin',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
