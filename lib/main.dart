import 'package:flutter/material.dart';

void main() {
  runApp(TillaApp());
}

class TillaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subrek!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.pinkAccent,
      ),
      home: SubscriptionsScreen(),
    );
  }
}

class Subscription {
  final String name;
  final double amount;
  final DateTime nextBillDate;
  final IconData icon;
  final String category;

  Subscription({
    required this.name,
    required this.amount,
    required this.nextBillDate,
    required this.icon,
    required this.category,
  });
}

class SubscriptionsScreen extends StatefulWidget {
  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  late List<Subscription> subscriptions = List.empty(growable: true);

  void _addSubscription(Subscription subscription) {
    setState(() {
      subscriptions.add(subscription);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Subscriptions'),
      ),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          return SubscriptionTile(subscription: subscriptions[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddSubscriptionScreen(onAdd: _addSubscription)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubscriptionTile extends StatelessWidget {
  final Subscription subscription;

  SubscriptionTile({required this.subscription});

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
        nextBillDate: _nextBillDate.add(Duration(days: 30)),
        icon: _selectedIcon,
        category: _categoryController.text,
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
