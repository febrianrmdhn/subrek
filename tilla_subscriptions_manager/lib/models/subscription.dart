// lib/models/subscription.dart

import 'package:flutter/material.dart';

class Subscription {
  final String name;
  final double amount;
  final DateTime nextBillDate;
  final IconData icon;

  Subscription({
    required this.name,
    required this.amount,
    required this.nextBillDate,
    required this.icon,
  });
}
