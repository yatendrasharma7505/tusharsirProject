import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> roles = [
    "Order Executive",
    "Manager",
    "Supervisor",
    "Admin",
  ];
  // String selectedRole = "Order Executive";
  int selectedCompany = 1;

  final List<Map<String, dynamic>> companies = [
    {
      "name": "Shree Textiles",
      "short": "ST",
      "bg": const Color(0xffDFF4EE),
      "text": const Color(0xff147C78),
    },
    {
      "name": "Metro Garments",
      "short": "MG",
      "bg": const Color(0xffE7E8FF),
      "text": const Color(0xff5B67D6),
    },
    {
      "name": "Urban Threads",
      "short": "UT",
      "bg": const Color(0xffFDEEE7),
      "text": const Color(0xffD3541A),
    },
  ];

  String selectedRole = "Order Executive";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(16.r), child: _buildTopBar()),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _label(Icons.person_outline, "Employee name"),

                  SizedBox(height: 10.h),

                  _textField(
                    controller: nameController,
                    hint: "e.g. Aarti Sharma",
                    keyboardType: TextInputType.name,
                  ),

                  SizedBox(height: 22.h),

                  _label(Icons.phone_outlined, "Phone number"),

                  SizedBox(height: 10.h),

                  _textField(
                    controller: phoneController,
                    hint: "+91...",
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 22.h),

                  _label(Icons.person_outline, "Role"),

                  SizedBox(height: 10.h),

                  _buildRoleDropdown(),

                  SizedBox(height: 26.h),

                  _label(Icons.apartment_outlined, "Assign to company"),

                  SizedBox(height: 14.h),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: companies.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      return _buildCompanyCard(index);
                    },
                  ),

                  SizedBox(height: 30.h),

                  _buildCreateEmployeeButton(),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------
  // TOP BAR
  //----------------------------------------------------

  Widget _buildCreateEmployeeButton() {
    return SizedBox(
      width: double.infinity,
      height: 62.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xffAAB6C8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
        onPressed: () {
          // Create Employee API
        },
        icon: Icon(Icons.person_add_alt_1, size: 22.sp),
        label: Text(
          "Create employee",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
    );
  }

  Widget _buildCompanyCard(int index) {
    final company = companies[index];
    final selected = selectedCompany == index;

    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: () {
        setState(() {
          selectedCompany = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffEEF1FF) : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: selected ? const Color(0xff5B67D6) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58.w,
              height: 58.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: company["bg"],
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                company["short"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: company["text"],
                ),
              ),
            ),

            SizedBox(width: 18.w),

            Expanded(
              child: Text(
                company["name"],
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? const Color(0xff5B67D6) : Colors.white,
                border: Border.all(
                  color: selected
                      ? const Color(0xff5B67D6)
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.fieldFill,
            child: Icon(Icons.arrow_back_ios_new, size: 18.sp),
          ),
        ),

        SizedBox(width: 14.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add employee",
              style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold),
            ),

            Text(
              "Assign a company",
              style: TextStyle(fontSize: 14.sp, color: AppColors.labelGrey),
            ),
          ],
        ),
      ],
    );
  }

  //----------------------------------------------------
  // LABEL
  //----------------------------------------------------

  Widget _label(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.labelGrey, size: 20.sp),

        SizedBox(width: 8.w),

        Text(
          title,
          style: TextStyle(
            color: AppColors.labelGrey,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  //----------------------------------------------------
  // TEXTFIELD
  //----------------------------------------------------

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //----------------------------------------------------
  // ROLE DROPDOWN
  //----------------------------------------------------

  Widget _buildRoleDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: TextStyle(fontSize: 17.sp, color: Colors.black87),
          items: roles.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedRole = value!;
            });
          },
        ),
      ),
    );
  }
}
