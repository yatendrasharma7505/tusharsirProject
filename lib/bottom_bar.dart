import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Cubits/auth/auth_cubit.dart';
import 'Cubits/dashboard/dashboard_cubit.dart';
import 'Cubits/order/order_cubit.dart';
import 'Screens/Home/Homescreen.dart';
import 'Screens/Order/Orderscreen.dart';
import 'Screens/Profile/Profilescreen.dart';
import 'Screens/Rank/Rankscreen.dart';
import 'Utils/app_colors.dart';
import 'Utils/app_haptics.dart';
import 'Widgets/custom_text.dart';

class BottomBar extends StatefulWidget {
  final int index;
  const BottomBar({super.key, this.index = 0});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  final List<Widget> _screens = const [
    Homescreen(),
    Orderscreen(),
    Rankscreen(),
    Profilescreen(),
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
                label: 'Home',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 1,
                icon: Icons.shopping_bag_outlined,
                activeIcon: Icons.shopping_bag,
                label: 'Order',
              ),
            ),
            GestureDetector(
              onTap: () async {
                AppHaptics.tap();
                final created = await Navigator.pushNamed(context, "/addOrderManualscreen");
                if (created == true && mounted) {
                  final userId = context.read<AuthCubit>().state.user?['id'] as String?;
                  context.read<OrderCubit>().loadOrders(employee: userId);
                  context.read<DashboardCubit>().loadDashboard();
                }
              },
              child: _buildAddButton(),
            ),
            Expanded(
              child: _buildNavItem(
                index: 2,
                icon: Icons.emoji_events_outlined,
                activeIcon: Icons.emoji_events,
                label: 'Rank',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 3,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
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
      onTap: () {
        AppHaptics.tap();
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? activeIcon : icon,
            size: 22.sp,
            color: selected ? AppColors.primary : AppColors.hintGrey,
          ),
          SizedBox(height: 4.h),
          CustomText(text: label, fontSize: 11.sp, fontWeight: selected ? FontWeight.w600 : FontWeight.normal, color: selected ? AppColors.primary : AppColors.hintGrey),
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
