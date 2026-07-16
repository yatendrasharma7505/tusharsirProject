import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black87,
      ),
    );
  }
}

class CustomTitleText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  const CustomTitleText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 18.sp,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black87,
      ),
    );
  }
}

class CustomSubText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  const CustomSubText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 12.sp,
        fontWeight: FontWeight.normal,
        color: color ?? AppColors.labelGrey,
      ),
    );
  }
}

class CustomStatText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;

  const CustomStatText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black87,
      ),
    );
  }
}

class CustomBadgeText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? bgColor;

  const CustomBadgeText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0xffEEF0FF),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 11.sp,
          fontWeight: FontWeight.w600,
          color: color ?? const Color(0xff5B67D6),
        ),
      ),
    );
  }
}
