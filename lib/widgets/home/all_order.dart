import 'package:flutter/material.dart';
import 'package:mobile_app/pages/details_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AllOrder extends StatelessWidget {
  final List<dynamic> orders;

  const AllOrder({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('All Orders')),
      body: Container(
        color: const Color.fromARGB(255, 235, 230, 230),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(order: orders[index]),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        orders[index]['order_no'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 102, 4),
                        ),
                      ),
                      subtitle: Text(
                        orders[index]['date'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      trailing: ElevatedButton.icon(
                        onPressed: () {
                          _openGoogleMaps(orders[index]['address']);
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
                              const Color.fromARGB(255, 234, 249, 246),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
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
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              orders[index]['mobile'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              orders[index]['name'],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      leading: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              orders[index]['address'],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      leading: const Icon(
                        Icons.location_city_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openGoogleMaps(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    String mapUrl =
        "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
    try {
      await launch(mapUrl);
    } catch (e) {
      print('Error launching Google Maps: $e');
    }
  }
}
