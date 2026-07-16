import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../Utils/app_colors.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Utils/app_haptics.dart';

class AddOrderManualscreen extends StatefulWidget {
  const AddOrderManualscreen({super.key});

  @override
  State<AddOrderManualscreen> createState() => _AddOrderManualscreenState();
}

class _AddOrderManualscreenState extends State<AddOrderManualscreen> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productDetailsController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  static const List<String> _categories = [
    'Kurti',
    'Saree',
    'Bedsheet',
    'T-Shirt',
  ];
  static const List<String> _assignees = [
    'Rahul Sharma',
    'Amit Verma',
    'Priya Singh',
  ];
  static const List<String> _statuses = [
    'New',
    'Accepted',
    'In process',
    'Packed',
  ];

  String _selectedCategory = _categories.first;
  String _selectedAssignee = _assignees.first;
  String _selectedStatus = _statuses.first;
  bool _isUrgent = false;
  File? _productPhoto;

  @override
  void initState() {
    super.initState();
    _customerNameController.addListener(_onFormChanged);
    _quantityController.addListener(_onFormChanged);
  }

  void _onFormChanged() => setState(() {});

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile == null) return;
    setState(() => _productPhoto = File(pickedFile.path));
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primary,
                  ),
                   title: CustomText(text: 'Take a photo'),
                  onTap: () {
                    AppHaptics.tap();
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library_outlined,
                    color: AppColors.primary,
                  ),
                   title: CustomText(text: 'Choose from gallery'),
                  onTap: () {
                    AppHaptics.tap();
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                if (_productPhoto != null)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: AppColors.logoutRed,
                    ),
                    title: CustomText(text: 'Remove photo', color: AppColors.logoutRed),
                    onTap: () {
                      AppHaptics.tap();
                      Navigator.pop(context);
                      setState(() => _productPhoto = null);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool get _isFormValid =>
      _customerNameController.text.trim().isNotEmpty &&
      _quantityController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _customerNameController.dispose();
    _phoneController.dispose();
    _quantityController.dispose();
    _productDetailsController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: _buildTopBar(context),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                children: [
                  _buildPhotoUpload(),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    icon: Icons.person_outline,
                    label: 'Customer name',
                    hint: 'e.g. Rajesh Kumar',
                    controller: _customerNameController,
                    bordered: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    icon: Icons.phone_outlined,
                    label: 'WhatsApp / mobile',
                    hint: '+91...',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    bordered: true,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          icon: Icons.tag,
                          label: 'Quantity (pcs)',
                          hint: '50',
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          bordered: true,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDropdownField(
                          icon: Icons.inventory_2_outlined,
                          label: 'Category',
                          value: _selectedCategory,
                          options: _categories,
                          onChanged: (value) =>
                              setState(() => _selectedCategory = value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    icon: Icons.description_outlined,
                    label: 'Product details',
                    hint: 'Sizes, colours, fabric...',
                    controller: _productDetailsController,
                    maxLines: 4,
                    bordered: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    icon: Icons.edit_note,
                    label: 'Order note',
                    hint: 'Optional internal note',
                    controller: _noteController,
                    bordered: true,
                  ),
                  SizedBox(height: 20.h),
                  _buildSectionLabel(
                    Icons.local_fire_department_outlined,
                    'Priority',
                  ),
                  SizedBox(height: 8.h),
                  _buildPriorityToggle(),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          icon: Icons.person_outline,
                          label: 'Assigned to',
                          value: _selectedAssignee,
                          options: _assignees,
                          onChanged: (value) =>
                              setState(() => _selectedAssignee = value),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDropdownField(
                          icon: Icons.layers_outlined,
                          label: 'Status',
                          value: _selectedStatus,
                          options: _statuses,
                          onChanged: (value) =>
                              setState(() => _selectedStatus = value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    label: 'Save order',
                    leadingIcon: Icons.save_outlined,
                    enabled: _isFormValid,
                    onPressed: () { AppHaptics.tap(); Navigator.of(context).maybePop(); },
                  ),
                ],
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
          onTap: () { AppHaptics.tap(); Navigator.of(context).maybePop(); },
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
            CustomTitleText(text: 'Add manual order', fontSize: 19.sp),
            CustomSubText(text: 'Type the details', fontSize: 13.sp),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotoUpload() {
    if (_productPhoto != null) {
      return GestureDetector(
        onTap: () { AppHaptics.tap(); _showImageSourceSheet(); },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.file(
                _productPhoto!,
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10.h,
              right: 10.w,
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () { AppHaptics.tap(); _showImageSourceSheet(); },
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.borderGrey,
          radius: 20.r,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.activeBadgeBackground,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 26.sp,
                  color: AppColors.activeBadgeText,
                ),
              ),
              SizedBox(height: 14.h),
              CustomTitleText(text: 'Upload product photo', fontSize: 16.sp),
              SizedBox(height: 4.h),
              CustomSubText(text: 'Tap to take or choose a photo', fontSize: 13.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppColors.labelGrey),
        SizedBox(width: 8.w),
        CustomText(text: text, fontSize: 14.sp, color: AppColors.labelGrey, fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _buildPriorityToggle() {
    return Row(
      children: [
        Expanded(
          child: _buildPriorityOption(
            label: 'Normal',
            icon: null,
            selected: !_isUrgent,
            onTap: () { AppHaptics.tap(); setState(() => _isUrgent = false); },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildPriorityOption(
            label: 'Urgent',
            icon: Icons.local_fire_department,
            selected: _isUrgent,
            onTap: () { AppHaptics.tap(); setState(() => _isUrgent = true); },
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityOption({
    required String label,
    required IconData? icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () { AppHaptics.tap(); onTap(); },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.activeBadgeBackground : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderGrey,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.sp,
                color: selected ? AppColors.primary : AppColors.labelGrey,
              ),
              SizedBox(width: 6.w),
            ],
            CustomText(text: label, fontSize: 15.sp, fontWeight: FontWeight.w600, color: selected ? AppColors.primary : AppColors.labelGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required IconData icon,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(icon, label),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.labelGrey),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              items: options
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: CustomText(text: option)),
                  )
                  .toList(),
              onChanged: (newValue) {
                if (newValue != null) onChanged(newValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  static const double _strokeWidth = 1.5;
  static const double _dashWidth = 6;
  static const double _dashSpace = 4;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + _dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + _dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}
