import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  OrderDetailsPage({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order No: ${orders[index]['order_no']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Name: ${orders[index]['name']}'),
                  SizedBox(height: 8),
                  Text('Mobile: ${orders[index]['mobile']}'),
                  SizedBox(height: 8),
                  Text('Address: ${orders[index]['address']}'),
                  SizedBox(height: 8),
                  Text('Date: ${orders[index]['date']}'),
                  SizedBox(height: 8),
                  Text('Status: ${orders[index]['status']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
