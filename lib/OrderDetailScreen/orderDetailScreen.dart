import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Cubits/order/order_cubit.dart';
import '../Cubits/order/order_state.dart';
import '../Utils/app_colors.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final List<String> _statuses = ['New', 'Accepted', 'In process', 'Packed', 'Completed'];
  String? _orderId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orderId = ModalRoute.of(context)?.settings.arguments as String?;
      if (_orderId != null) {
        context.read<OrderCubit>().loadOrder(_orderId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final order = state.selectedOrder;
        final customerName = order?['customerName'] as String? ?? 'Order Details';
        final orderNumber = order?['orderNumber'] as String? ?? '';
        final status = order?['status'] as String? ?? 'New';
        final customerPhone = order?['customerPhone'] as String? ?? '';
        final quantity = order?['quantity'] ?? 0;
        final category = order?['category'] as String? ?? '';
        final productDetails = order?['productDetails'] as String? ?? '';
        final uploadedBy = order?['uploadedBy'];
        final uploaderName = uploadedBy is Map<String, dynamic>
            ? (uploadedBy['name'] as String? ?? '')
            : '';
        final assignedTo = order?['assignedTo'];
        final assigneeName = assignedTo is Map<String, dynamic>
            ? (assignedTo['name'] as String? ?? '')
            : '';

        return Scaffold(
          backgroundColor: const Color(0xFFF0F5F9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF182333)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: BlocListener<OrderCubit, OrderState>(
            listenWhen: (prev, curr) => prev.errorMessage != curr.errorMessage && curr.errorMessage != null,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!), backgroundColor: AppColors.logoutRed),
              );
            },
            child: state.status == OrderStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderHeader(customerName, orderNumber, status),
                      SizedBox(height: 28.h),
                      _buildOrderDetailsCard(customerPhone, quantity, category, productDetails, uploaderName, assigneeName),
                      SizedBox(height: 28.h),
                      _buildStatusSection(status, _orderId ?? ''),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }

  Widget _buildOrderHeader(String customerName, String orderNumber, String status) {
    final statusColor = _statusColor(status);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(customerName, style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w700, color: const Color(0xFF182333))),
              SizedBox(height: 3.h),
              Text(orderNumber, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF8292AA))),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: (statusColor['bg'] as Color?)?.withValues(alpha: 0.15) ?? const Color(0xFFE2F4F1),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(status,
            style: TextStyle(
              fontSize: 15.sp, fontWeight: FontWeight.w600,
              color: statusColor['fg'] as Color? ?? const Color(0xFF008778),
            ),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _statusColor(String status) {
    switch (status) {
      case 'New': return {'bg': const Color(0xFF2F63F4), 'fg': const Color(0xFF2F63F4)};
      case 'Accepted': return {'bg': const Color(0xFF008778), 'fg': const Color(0xFF008778)};
      case 'In process': return {'bg': const Color(0xFFC07A08), 'fg': const Color(0xFFC07A08)};
      case 'Packed': return {'bg': const Color(0xFF7B4FC0), 'fg': const Color(0xFF7B4FC0)};
      case 'Completed': return {'bg': const Color(0xFF1D8A3F), 'fg': const Color(0xFF1D8A3F)};
      case 'Cancelled': return {'bg': const Color(0xFFD32F2F), 'fg': const Color(0xFFD32F2F)};
      default: return {'bg': const Color(0xFF2F63F4), 'fg': const Color(0xFF2F63F4)};
    }
  }

  Widget _buildOrderDetailsCard(
    String phone,
    dynamic quantity,
    String category,
    String productDetails,
    String uploaderName,
    String assigneeName,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 22.r, offset: Offset(0, 10.h))],
      ),
      child: Column(
        children: [
          _buildDetailItem(Icons.phone_outlined, 'Customer phone', phone),
          _buildDivider(),
          _buildDetailItem(Icons.tag, 'Quantity', '$quantity pieces'),
          _buildDivider(),
          _buildDetailItem(Icons.inventory_2_outlined, 'Category', category),
          _buildDivider(),
          _buildDetailItem(Icons.description_outlined, 'Product details', productDetails),
          _buildDivider(),
          _buildDetailItem(Icons.assignment_ind_outlined, 'Assigned to', assigneeName.isNotEmpty ? assigneeName : 'Unassigned'),
          _buildDivider(),
          _buildDetailItem(Icons.person_outline, 'Uploaded by', uploaderName),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 25.sp, color: const Color(0xFF8292AA)),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400, color: const Color(0xFF8292AA))),
                SizedBox(height: 8.h),
                Text(value, style: TextStyle(fontSize: 17.sp, height: 1.3, fontWeight: FontWeight.w500, color: const Color(0xFF182333))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1.h, thickness: 1, color: const Color(0xFFE3E9F0));
  }

  Widget _buildStatusSection(String currentStatus, String orderId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Update status', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: const Color(0xFF182333))),
        SizedBox(height: 16.h),
        SizedBox(
          height: 48.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _statuses.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final status = _statuses[index];
              final isSelected = currentStatus == status;
              final isPast = _statuses.indexOf(currentStatus) > index;
              final enabled = !isPast && !isSelected;

              return GestureDetector(
                onTap: enabled && orderId.isNotEmpty
                    ? () => context.read<OrderCubit>().updateStatus(orderId, status)
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0E8C80) : Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF0E8C80) : (enabled ? const Color(0xFFE1E7EF) : Colors.grey.shade200),
                    ),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : (enabled ? const Color(0xFF33415C) : Colors.grey.shade400),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        if (orderId.isNotEmpty)
          Center(
            child: Text(
              'Tap a status to move order forward',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            ),
          ),
      ],
    );
  }
}
