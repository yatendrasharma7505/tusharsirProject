import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/company_model.dart';
import '../Utils/app_colors.dart';
import 'custom_text.dart';

class CompanyTile extends StatelessWidget {
  final CompanyModel company;
  final bool selected;
  final VoidCallback onTap;

  const CompanyTile({
    super.key,
    required this.company,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.selectedGreen : AppColors.borderGrey,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: company.avatarBackground,
              child: CustomText(text: company.initials, fontWeight: FontWeight.bold, color: company.avatarTextColor),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: CustomText(text: company.name, fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            selected
                ? CircleAvatar(
                    radius: 12.r,
                    backgroundColor: AppColors.selectedGreen,
                    child: Icon(Icons.check, size: 14.sp, color: Colors.white),
                  )
                : Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.borderGrey,
                        width: 1.5,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
