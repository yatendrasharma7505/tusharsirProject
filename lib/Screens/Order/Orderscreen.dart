import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Model/order_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_routes.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderModel.sampleOrders;
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _buildSearchBar(),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                '${orders.length} orders',
                style: TextStyle(fontSize: 14.sp, color: AppColors.labelGrey),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                itemCount: orders.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) =>
                    _buildOrderCard(orders[index]),
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
        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All orders',
              style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '${OrderModel.sampleOrders.length} total',
              style: TextStyle(fontSize: 13.sp, color: AppColors.labelGrey),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.notification),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.fieldFill,
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                  size: 19.sp,
                ),
              ),
              Positioned(
                top: 2.h,
                right: 2.w,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: const BoxDecoration(
                    color: AppColors.logoutRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20.sp, color: AppColors.hintGrey),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search customer, order #, product',
                hintStyle: TextStyle(
                  color: AppColors.hintGrey,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
          Icon(Icons.filter_alt_outlined, size: 20.sp, color: AppColors.hintGrey),
        ],
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: order.iconBackground,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  order.productIcon,
                  size: 26.sp,
                  color: order.iconColor,
                ),
              ),
              Positioned(
                bottom: -2.h,
                right: -2.w,
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: const Color(0xFF3FAE5C),
                  child: Icon(
                    Icons.chat_bubble,
                    size: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        order.customerName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildStatusPill(order),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '${order.product} · ${order.pieces} pcs · ${order.orderNumber}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.labelGrey,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.r,
                      backgroundColor: order.assigneeColor,
                      child: Text(
                        order.assigneeInitials,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        order.assigneeName,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (order.isUrgent) ...[
                      _buildUrgentPill(),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      order.time,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.hintGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(OrderModel order) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: order.statusBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        order.status,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: order.statusColor,
        ),
      ),
    );
  }

  Widget _buildUrgentPill() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4E1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            size: 12.sp,
            color: AppColors.logoutRed,
          ),
          SizedBox(width: 3.w),
          Text(
            'Urgent',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.logoutRed,
            ),
          ),
        ],
      ),
    );
  }
}
