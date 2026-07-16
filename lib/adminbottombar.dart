import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tusharsirproject/DashboardScreen/Dashboardscreen.dart';
import 'package:tusharsirproject/ReportScreen/ReportScreen.dart';
import 'package:tusharsirproject/Screens/SettingScreen/SetingScreen.dart';
import 'package:tusharsirproject/TeamScreen/TeamScreen.dart';
import 'Utils/app_colors.dart';

class Adminbottombar extends StatefulWidget {
  final int index;
  Adminbottombar({super.key, this.index = 0});

  @override
  State<Adminbottombar> createState() => _AdminbottombarState();
}

class _AdminbottombarState extends State<Adminbottombar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  final List<Widget> _screens = const [
    DashboardScreen(),
    TeamScreen(),
    ReportScreen(),
    Setingscreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Dashboard',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 1,
                icon: Icons.people,
                activeIcon: Icons.people,
                label: 'Team',
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, "/addOrderManualscreen"),
              child: _buildAddButton(),
            ),
            Expanded(
              child: _buildNavItem(
                index: 2,
                icon: Icons.bar_chart_sharp,
                activeIcon: Icons.bar_chart_sharp,
                label: 'Reports',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 3,
                icon: Icons.settings,
                activeIcon: Icons.settings,
                label: 'Settings',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool selected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? activeIcon : icon,
            size: 22.sp,
            color: selected ? AppColors.primary : AppColors.hintGrey,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              color: selected ? AppColors.primary : AppColors.hintGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 60.w,
      height: 44.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.background],
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.add, color: Colors.white, size: 24.sp),
    );
  }
}
