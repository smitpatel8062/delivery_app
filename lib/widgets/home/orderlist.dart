import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:mobile_app/pages/details_page.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderList extends StatefulWidget {
  final List<dynamic> orders;

  const OrderList({super.key, required this.orders});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 235, 230, 230),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(order: widget.orders[index]),
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
                      widget.orders[index]['order_no'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 177, 102, 4),
                      ),
                    ),
                    subtitle: Text(
                      widget.orders[index]['date'],
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: () {
                        _openGoogleMaps(widget.orders[index]['address']);
                      },
                      icon: const Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 69, 127, 114),
                      ),
                      label: const Text(
                        'MAP',
                        style:
                            TextStyle(color: Color.fromARGB(255, 69, 127, 114)),
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
                            widget.orders[index]['mobile'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
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
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.orders[index]['name'],
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
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.orders[index]['address'],
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
      ),
    );
  }

  // Function to open Google Maps with a specific address
  void _openGoogleMaps(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    String mapUrl = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
    try {
      await launch(mapUrl);
    } catch (e) {
      print('Error launching Google Maps: $e');
    }
  }
}
