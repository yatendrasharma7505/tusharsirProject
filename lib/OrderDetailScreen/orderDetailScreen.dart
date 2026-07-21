import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final List<String> _statuses = [
    'New',
    'Accepted',
    'In process',
    'Packed',
    'Completed',
  ];

  String _selectedStatus = 'Accepted';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 18.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderHeader(),
              SizedBox(height: 28.h),
              _buildOrderDetailsCard(),
              SizedBox(height: 28.h),
              _buildStatusSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meena Traders',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF182333),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'OD-1041 · 10:21',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8292AA),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 7.h,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE2F4F1),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            _selectedStatus,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF008778),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 22.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailItem(
            icon: Icons.phone_outlined,
            title: 'Customer phone',
            value: '+91 99887 55012',
          ),
          _buildDivider(),
          _buildDetailItem(
            icon: Icons.tag,
            title: 'Quantity',
            value: '24 pieces',
          ),
          _buildDivider(),
          _buildDetailItem(
            icon: Icons.inventory_2_outlined,
            title: 'Category',
            value: 'Bedsheet',
          ),
          _buildDivider(),
          _buildDetailItem(
            icon: Icons.description_outlined,
            title: 'Product details',
            value: 'Double bedsheet, floral, pack of 2',
          ),
          _buildDivider(),
          _buildDetailItem(
            icon: Icons.person_outline,
            title: 'Uploaded by',
            value: 'Amit Verma',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 25.sp,
            color: const Color(0xFF8292AA),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8292AA),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 17.sp,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF182333),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.h,
      thickness: 1,
      color: const Color(0xFFE3E9F0),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Update status',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF182333),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 48.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _statuses.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final status = _statuses[index];
              final isSelected = _selectedStatus == status;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedStatus = status;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF0E8C80)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0E8C80)
                          : const Color(0xFFE1E7EF),
                    ),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF33415C),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}