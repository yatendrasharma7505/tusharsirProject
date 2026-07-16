import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? leadingIconColor;
  final bool filled;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingIconColor,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = filled ? Colors.white : Colors.black87;
    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 18.sp, color: leadingIconColor ?? textColor),
          SizedBox(width: 8.w),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: filled ? 16.sp : 15.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: 8.w),
          Icon(trailingIcon, size: 18.sp, color: textColor),
        ],
      ],
    );

    if (filled) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: content,
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        side: const BorderSide(color: AppColors.borderGrey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: content,
    );
  }
}
