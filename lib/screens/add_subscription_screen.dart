// lib/screens/add_subscription_screen.dart

import 'package:flutter/material.dart';

import '../models/subscription.dart';

class AddSubscriptionScreen extends StatefulWidget {
  final Function(Subscription) onAdd;

  AddSubscriptionScreen({required this.onAdd});

  @override
  _AddSubscriptionScreenState createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  DateTime _nextBillDate = DateTime.now();
  IconData _selectedIcon = Icons.subscriptions;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newSubscription = Subscription(
        name: _nameController.text,
        amount: double.parse(_amountController.text),
        nextBillDate: _nextBillDate,
        icon: _selectedIcon,
      );
      widget.onAdd(newSubscription);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subscription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Subscription Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text(
                    'Next Bill Date: ${_nextBillDate.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text('Icon:'),
                trailing: Icon(_selectedIcon),
                onTap: _selectIcon,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Subscription'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _nextBillDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _nextBillDate)
      setState(() {
        _nextBillDate = picked;
      });
  }

  _selectIcon() async {
    // Implement icon selection here
    // For simplicity, we're just going to toggle between two icons
    setState(() {
      _selectedIcon =
          _selectedIcon == Icons.subscriptions ? Icons.tv : Icons.subscriptions;
    });
  }
}
