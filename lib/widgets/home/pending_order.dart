import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/pages/details_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({super.key, required List orders});

  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  List<dynamic> _orders = [];

  @override
  void initState() {
    super.initState();
    loadOrderData();
  }

   Future<void> loadOrderData() async {
    String jsonString = await rootBundle.loadString('assets/order.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if (jsonData.containsKey('data') && jsonData['data'] != null) {
      List<dynamic> orders = jsonData['data'];
      List<dynamic> pendingOrders =
          orders.where((order) => order['status'] == 'pending').toList();
      setState(() {
        _orders = pendingOrders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Orders'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 235, 230, 230),
        child: _orders.isNotEmpty
            ? ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(order: _orders[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              _orders[index]['order_no'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 177, 102, 4),
                              ),
                            ),
                            subtitle: Text(
                              _orders[index]['date'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            trailing: ElevatedButton.icon(
                              onPressed: () {
                                _openGoogleMaps(_orders[index]['address']);
                              },
                              icon: const Icon(
                                Icons.location_pin,
                                color: Color.fromARGB(255, 69, 127, 114),
                              ),
                              label: const Text(
                                'MAP',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 69, 127, 114)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    (const Color.fromARGB(255, 234, 249, 246)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  // Adjust the value as needed
                                ),
                              ),
                            ),
                            leading: const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 177, 102, 4),
                              child: Icon(
                                Icons.local_shipping_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Divider(height: 5),
                          ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _orders[index]['mobile'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.phone,
                              color: Colors.grey[500],
                            ),
                          ),
                          ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _orders[index]['name'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.person,
                              color: Colors.grey[500],
                            ),
                          ),
                          ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _orders[index]['address'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.location_city_rounded,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/d-2.png',
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      'No Orders Pending',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _openGoogleMaps(String address) async {
    String encodedAddress = Uri.encodeComponent('index , address');
    String mapUrl =
        "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
    try {
      await launch(mapUrl);
    } catch (e) {
      print('Error launching Google Maps: $e');
    }
  }
}
