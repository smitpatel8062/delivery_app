import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/widgets/home/all_order.dart';
import 'package:mobile_app/widgets/home/bottom_menu.dart';
import 'package:mobile_app/widgets/home/delivered_order.dart';
import 'package:mobile_app/widgets/home/pending_order.dart';  

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _orders = [];
  List<dynamic> _filteredOrders = [];
  List<dynamic> _deliveredOrders = [];
  List<dynamic> _pendingOrders = [];

  @override
  void initState() {
    super.initState();
    loadOrderData();
  }

  Future<void> loadOrderData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/order.json');
      Map<String, dynamic> jsonMap = json.decode(jsonData);
      setState(() {
        _orders = jsonMap['data'];
        _filteredOrders = _orders;
        _deliveredOrders = _orders.where((order) => order['status'] == 'Delivered').toList();
        _pendingOrders = _orders.where((order) => order['status'] == 'Pending').toList();
      });
    } catch (e) {
      print('Error loading order data: $e');
    }
  }

  void _searchOrders(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredOrders = _orders;
      } else {
        _filteredOrders = _orders.where((order) {
          final orderNo = order['order_no'].toString().toLowerCase();
          final name = order['name'].toString().toLowerCase();
          final mobile = order['mobile'].toString().toLowerCase();
          final searchQuery = query.toLowerCase();

          return orderNo.contains(searchQuery) ||
              name.contains(searchQuery) ||
              mobile.contains(searchQuery);
        }).toList();
      }
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filteredOrders = _orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 15, 102, 86),
            leading: _isSearching
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: _stopSearch,
                  )
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ),
                      );
                    },
                  ),
            title: _isSearching
                ? TextField(
                    onChanged: _searchOrders,
                    controller: _searchController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search Order No, Name, Mobile no ...',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  )
                : const Text(
                    'Orders',
                    style: TextStyle(color: Colors.white),
                  ),
            actions: _isSearching
                ? <Widget>[
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                      onPressed: _stopSearch,
                    ),
                  ]
                : <Widget>[
                    IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      onPressed: _startSearch,
                    ),
                  ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 221, 223, 222),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 1.0,
                    )
                  ],
                ),
                child: const TabBar(
                  indicatorColor: Color.fromARGB(255, 15, 102, 86),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Delivered'),
                    Tab(text: 'Pending'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrderTab(AllOrder(orders: _filteredOrders)),
                    _buildOrderTab(DeliveredOrder(orders: _deliveredOrders)),
                    _buildOrderTab(PendingOrder(orders: _pendingOrders)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderTab(Widget orderWidget) {
    return _filteredOrders.isEmpty
        ? const Center(
            child: Text(
              'No data found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : orderWidget;
  }
}
