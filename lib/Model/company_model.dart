import 'package:flutter/material.dart';

class CompanyModel {
  final String id;
  final String name;
  final String initials;
  final Color avatarBackground;
  final Color avatarTextColor;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.initials,
    required this.avatarBackground,
    required this.avatarTextColor,
  });

  static const List<CompanyModel> sampleCompanies = [
    CompanyModel(
      id: 'shree_textiles',
      name: 'Shree Textiles',
      initials: 'ST',
      avatarBackground: Color(0xFFDCEDE9),
      avatarTextColor: Color(0xFF2E6C64),
    ),
    CompanyModel(
      id: 'metro_garments',
      name: 'Metro Garments',
      initials: 'MG',
      avatarBackground: Color(0xFFE3E1FB),
      avatarTextColor: Color(0xFF6C63D6),
    ),
    CompanyModel(
      id: 'urban_threads',
      name: 'Urban Threads',
      initials: 'UT',
      avatarBackground: Color(0xFFFBE6D8),
      avatarTextColor: Color(0xFFD2762E),
    ),
  ];
}
