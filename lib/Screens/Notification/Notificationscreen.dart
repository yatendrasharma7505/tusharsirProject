import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/notification/notification_cubit.dart';
import '../../Cubits/notification/notification_state.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Widgets/custom_text.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final items = state.notifications ?? [];
        final unread = state.unreadCount;
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: _buildTopBar(context, unread),
                ),
                if (state.status == NotificationStatus.loading)
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                else if (items.isEmpty)
                  Expanded(child: Center(child: CustomSubText(text: 'No notifications', fontSize: 14.sp)))
                else
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) => _buildNotificationCard(items[index] as Map<String, dynamic>),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, int unread) {
    return Row(
      children: [
        GestureDetector(
          onTap: () { AppHaptics.tap(); Navigator.of(context).maybePop(); },
          child: CircleAvatar(
            radius: 20.r, backgroundColor: AppColors.fieldFill,
            child: Icon(Icons.chevron_left, size: 22.sp, color: Colors.black87),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(text: 'Notifications', fontSize: 20.sp),
            CustomSubText(text: '$unread unread', fontSize: 13.sp),
          ],
        ),
        const Spacer(),
        if (unread > 0)
          GestureDetector(
            onTap: () { context.read<NotificationCubit>().markAllAsRead(); },
            child: CustomText(text: 'Mark all read', fontSize: 13.sp, color: AppColors.primary, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    final type = item['type'] as String? ?? '';
    final title = item['title'] as String? ?? '';
    final detail = item['detail'] as String? ?? '';
    final isRead = item['read'] as bool? ?? false;
    final createdAt = item['createdAt'] as String? ?? '';

    IconData icon;
    Color iconBackground;
    Color iconColor;
    Color? stripColor;

    switch (type) {
      case 'new_order':
        icon = Icons.shopping_bag_outlined;
        iconBackground = const Color(0xFFDCEDE9);
        iconColor = const Color(0xFF2E6C64);
        stripColor = const Color(0xFF2E6C64);
        break;
      case 'duplicate_alert':
        icon = Icons.warning_amber_rounded;
        iconBackground = const Color(0xFFFBE6D8);
        iconColor = const Color(0xFFD2762E);
        stripColor = const Color(0xFFD2762E);
        break;
      case 'status_change':
        icon = Icons.inventory_2_outlined;
        iconBackground = const Color(0xFFE3E1FB);
        iconColor = const Color(0xFF6C63D6);
        break;
      default:
        icon = Icons.notifications_none;
        iconBackground = AppColors.fieldFill;
        iconColor = AppColors.hintGrey;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isRead ? AppColors.card : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(left: BorderSide(color: stripColor ?? Colors.transparent, width: 3.w)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r, backgroundColor: iconBackground,
            child: Icon(icon, size: 20.sp, color: iconColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child:                       CustomText(text: title, fontSize: 15.sp, fontWeight: isRead ? FontWeight.normal : FontWeight.w600),
                    ),
                    CustomSubText(text: _timeAgo(createdAt), fontSize: 12.sp, color: AppColors.hintGrey),
                  ],
                ),
                SizedBox(height: 4.h),
                CustomSubText(text: detail, fontSize: 13.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final diff = DateTime.now().difference(date);
      if (diff.inMinutes < 1) return 'Now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m';
      if (diff.inHours < 24) return '${diff.inHours}h';
      return '${diff.inDays}d';
    } catch (_) {
      return '';
    }
  }
}
