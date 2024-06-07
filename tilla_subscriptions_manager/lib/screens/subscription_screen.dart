// lib/screens/subscriptions_screen.dart

import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../widgets/subscription_card.dart';

class SubscriptionsScreen extends StatelessWidget {
  final List<Subscription> subscriptions;

  SubscriptionsScreen(this.subscriptions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Subscriptions'),
      ),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          return SubscriptionCard(subscription: subscriptions[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_subscription');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
