import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/auth/auth_cubit.dart';
import '../../Cubits/order/order_cubit.dart';
import '../../Cubits/order/order_state.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_haptics.dart';
import '../../Utils/app_routes.dart';
import '../../Widgets/custom_text.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _userId;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.user;
    _userId = user?['id'] as String?;
    context.read<OrderCubit>().loadOrders(employee: _userId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final orders = state.orders ?? [];
        final total = state.pagination?['total'] ?? orders.length;
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: _buildTopBar(context, total as int),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildSearchBar(),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => context.read<OrderCubit>().loadOrders(employee: _userId),
                    child: state.status == OrderStatus.loading && orders.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : state.status == OrderStatus.error && orders.isEmpty
                            ? ListView(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 100.h),
                                      child: CustomText(text: state.errorMessage ?? 'Failed to load', color: AppColors.logoutRed),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                                itemCount: orders.length,
                                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                                itemBuilder: (context, index) => _buildOrderCard(orders[index] as Map<String, dynamic>),
                              ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, int total) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r, backgroundColor: AppColors.primary,
          child: Icon(Icons.crop_free, color: Colors.white, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(text: 'All orders', fontSize: 19.sp),
            CustomSubText(text: '$total total', fontSize: 13.sp),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () { AppHaptics.tap(); Navigator.pushNamed(context, AppRoutes.notification); },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 20.r, backgroundColor: AppColors.fieldFill,
                child: Icon(Icons.notifications_none, color: Colors.black87, size: 19.sp),
              ),
              Positioned(
                top: 2.h, right: 2.w,
                child: Container(
                  width: 9.w, height: 9.w,
                  decoration: const BoxDecoration(color: AppColors.logoutRed, shape: BoxShape.circle),
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
              onSubmitted: (value) => context.read<OrderCubit>().loadOrders(search: value),
              decoration: InputDecoration(
                hintText: 'Search customer, order #, product',
                hintStyle: TextStyle(color: AppColors.hintGrey, fontSize: 14.sp),
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

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final customerName = order['customerName'] as String? ?? '';
    final orderNumber = order['orderNumber'] as String? ?? '';
    final quantity = order['quantity'] ?? 0;
    final category = order['category'] as String? ?? '';
    final status = order['status'] as String? ?? 'New';
    final priority = order['priority'] as String? ?? 'Normal';
    // Show who the order is assigned to (who's actually responsible for it),
    // falling back to the uploader for older/admin-created orders with no assignee.
    final assignedTo = order['assignedTo'] as Map<String, dynamic>?;
    final uploadedBy = order['uploadedBy'] as Map<String, dynamic>?;
    final assigneeName = (assignedTo ?? uploadedBy)?['name'] as String? ?? '';
    final assigneeInitials = assigneeName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();

    final statusColors = _statusStyle(status);
    final isUrgent = priority == 'Urgent';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/orderDetailScreen", arguments: order['_id']),
      child: Container(
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
                  width: 56.w, height: 56.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(Icons.inventory_2_outlined, size: 26.sp, color: AppColors.primary),
                ),
                if (isUrgent)
                  Positioned(
                    bottom: -2.h, right: -2.w,
                    child: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: AppColors.logoutRed,
                      child: Icon(Icons.local_fire_department, size: 10.sp, color: Colors.white),
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
                        child: CustomTitleText(text: customerName, fontSize: 15.sp),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: statusColors['bg'] as Color?,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CustomText(
                          text: status, fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColors['fg'] as Color?,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomSubText(text: '$category · $quantity pcs · $orderNumber', fontSize: 13.sp),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r, backgroundColor: AppColors.primary,
                        child: CustomText(
                          text: assigneeInitials, fontSize: 9.sp,
                          fontWeight: FontWeight.bold, color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: CustomText(text: assigneeName, fontSize: 13.sp),
                      ),
                      if (isUrgent) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE4E1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department, size: 12.sp, color: AppColors.logoutRed),
                              SizedBox(width: 3.w),
                              CustomText(text: 'Urgent', fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColors.logoutRed),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      CustomSubText(text: '', fontSize: 12.sp, color: AppColors.hintGrey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _statusStyle(String status) {
    switch (status) {
      case 'New':
        return {'bg': const Color(0xFFEEF3FF), 'fg': const Color(0xFF2F63F4)};
      case 'Accepted':
        return {'bg': const Color(0xFFE8F8F4), 'fg': const Color(0xFF127A73)};
      case 'In process':
        return {'bg': const Color(0xFFFFF4DF), 'fg': const Color(0xFFC07A08)};
      case 'Packed':
        return {'bg': const Color(0xFFF0E6FF), 'fg': const Color(0xFF7B4FC0)};
      case 'Completed':
        return {'bg': const Color(0xFFE8F8E8), 'fg': const Color(0xFF1D8A3F)};
      case 'Cancelled':
        return {'bg': const Color(0xFFFFE8E8), 'fg': const Color(0xFFD32F2F)};
      default:
        return {'bg': const Color(0xFFEEF3FF), 'fg': const Color(0xFF2F63F4)};
    }
  }
}
