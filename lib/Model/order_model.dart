import 'package:flutter/material.dart';

class OrderModel {
  final String customerName;
  final String product;
  final int pieces;
  final String orderNumber;
  final IconData productIcon;
  final Color iconBackground;
  final Color iconColor;
  final String assigneeInitials;
  final String assigneeName;
  final Color assigneeColor;
  final String status;
  final Color statusBackground;
  final Color statusColor;
  final String time;
  final bool isUrgent;

  const OrderModel({
    required this.customerName,
    required this.product,
    required this.pieces,
    required this.orderNumber,
    required this.productIcon,
    required this.iconBackground,
    required this.iconColor,
    required this.assigneeInitials,
    required this.assigneeName,
    required this.assigneeColor,
    required this.status,
    required this.statusBackground,
    required this.statusColor,
    required this.time,
    this.isUrgent = false,
  });

  static const List<OrderModel> sampleOrders = [
    OrderModel(
      customerName: 'Rajesh Kumar',
      product: 'Kurti',
      pieces: 50,
      orderNumber: 'OD-1042',
      productIcon: Icons.checkroom_outlined,
      iconBackground: Color(0xFFDCEAF0),
      iconColor: Color(0xFF3E7A96),
      assigneeInitials: 'RS',
      assigneeName: 'Rahul',
      assigneeColor: Color(0xFF2E6C64),
      status: 'New',
      statusBackground: Color(0xFFE3E9FB),
      statusColor: Color(0xFF4C63C4),
      time: '10:42',
      isUrgent: true,
    ),
    OrderModel(
      customerName: 'Meena Traders',
      product: 'Bedsheet',
      pieces: 24,
      orderNumber: 'OD-1041',
      productIcon: Icons.layers_outlined,
      iconBackground: Color(0xFFDCEDE4),
      iconColor: Color(0xFF3E8A6A),
      assigneeInitials: 'AV',
      assigneeName: 'Amit',
      assigneeColor: Color(0xFFD98C3D),
      status: 'Accepted',
      statusBackground: Color(0xFFDCEDE9),
      statusColor: Color(0xFF2E6C64),
      time: '10:21',
    ),
    OrderModel(
      customerName: 'Sana Boutique',
      product: 'Saree',
      pieces: 12,
      orderNumber: 'OD-1040',
      productIcon: Icons.checkroom_outlined,
      iconBackground: Color(0xFFE3E1FB),
      iconColor: Color(0xFF6C63D6),
      assigneeInitials: 'PS',
      assigneeName: 'Priya',
      assigneeColor: Color(0xFF6C63D6),
      status: 'In process',
      statusBackground: Color(0xFFF6EAC9),
      statusColor: Color(0xFFAD7A32),
      time: '09:58',
    ),
    OrderModel(
      customerName: 'Arvind Stores',
      product: 'T-Shirt',
      pieces: 80,
      orderNumber: 'OD-1039',
      productIcon: Icons.checkroom_outlined,
      iconBackground: Color(0xFFE9EAEC),
      iconColor: Color(0xFF6B7280),
      assigneeInitials: 'RS',
      assigneeName: 'Rahul',
      assigneeColor: Color(0xFF2E6C64),
      status: 'Packed',
      statusBackground: Color(0xFFE3E1FB),
      statusColor: Color(0xFF6C63D6),
      time: '09:40',
      isUrgent: true,
    ),
  ];
}
