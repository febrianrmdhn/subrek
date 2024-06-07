// lib/widgets/subscription_card.dart

import 'package:flutter/material.dart';
import '../models/subscription.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  SubscriptionCard({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Tambahkan bayangan kartu
      margin: EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // Atur margin kartu
      child: ListTile(
        contentPadding: EdgeInsets.all(16), // Atur padding konten
        leading: Icon(subscription.icon),
        title: Text(
          subscription.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Next Bill Date:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Amount:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${subscription.amount.toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }
}
