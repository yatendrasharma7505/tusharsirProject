import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';

class _NotificationItem {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;
  final Color? stripColor;

  const _NotificationItem({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
    this.stripColor,
  });
}

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  static const List<_NotificationItem> _items = [
    _NotificationItem(
      icon: Icons.shopping_bag_outlined,
      iconBackground: Color(0xFFDCEDE9),
      iconColor: Color(0xFF2E6C64),
      title: 'New WhatsApp order',
      subtitle: 'Rajesh Kumar · 50 pcs Kurti — imported by Rahul',
      time: '2m',
      stripColor: Color(0xFF2E6C64),
    ),
    _NotificationItem(
      icon: Icons.warning_amber_rounded,
      iconBackground: Color(0xFFFBE6D8),
      iconColor: Color(0xFFD2762E),
      title: 'Possible duplicate',
      subtitle: 'Rajesh Kumar ordered a similar item 18 min ago',
      time: '18m',
      stripColor: Color(0xFFD2762E),
    ),
    _NotificationItem(
      icon: Icons.inventory_2_outlined,
      iconBackground: Color(0xFFE3E1FB),
      iconColor: Color(0xFF6C63D6),
      title: 'Order packed',
      subtitle: 'OD-1039 marked Packed by Rahul',
      time: '1h',
    ),
    _NotificationItem(
      icon: Icons.inventory_2_outlined,
      iconBackground: Color(0xFFE3E1FB),
      iconColor: Color(0xFF6C63D6),
      title: 'Order completed',
      subtitle: 'OD-1038 marked Completed by Sneha',
      time: '2h',
    ),
    _NotificationItem(
      icon: Icons.trending_up,
      iconBackground: Color(0xFFDCEDE9),
      iconColor: Color(0xFF2E6C64),
      title: 'Daily target 78%',
      subtitle: '118 of 150 orders done. Keep going!',
      time: '3h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: _buildTopBar(context),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                itemCount: _items.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) =>
                    _buildNotificationCard(_items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.fieldFill,
            child: Icon(Icons.chevron_left, size: 22.sp, color: Colors.black87),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '2 unread',
              style: TextStyle(fontSize: 13.sp, color: AppColors.labelGrey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationCard(_NotificationItem item) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(
          left: BorderSide(
            color: item.stripColor ?? Colors.transparent,
            width: 3.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: item.iconBackground,
            child: Icon(item.icon, size: 20.sp, color: item.iconColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.hintGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.labelGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
