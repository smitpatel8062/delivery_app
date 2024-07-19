import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/widgets/home/orderlist.dart';
import 'package:mobile_app/widgets/home/recent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _orders = [];
  List<dynamic> _filteredOrders = [];
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _hasSearchInput = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    loadOrderData();
    _searchController.addListener(() {
      _hasSearchInput.value = _searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadOrderData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/order.json');
      Map<String, dynamic> jsonMap = json.decode(jsonData);
      setState(() {
        _orders = jsonMap['data'];
        _filteredOrders = _orders;
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
          final orderNo = order['order_no'].toLowerCase();
          final name = order['name'].toLowerCase();
          final mobile = order['mobile'].toLowerCase();
          final searchQuery = query.toLowerCase();

          return orderNo.contains(searchQuery) ||
              name.contains(searchQuery) ||
              mobile.contains(searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight =
        screenHeight - kToolbarHeight - kBottomNavigationBarHeight;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 15, 102, 86),
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'DELIVERY APP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _searchOrders,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Order id, Name & Mobile Num...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _hasSearchInput,
                    builder: (context, hasInput, child) {
                      return IconButton(
                        icon: Icon(
                          hasInput ? Icons.close : Icons.search,
                          color: Colors.grey,
                        ),
                        onPressed: hasInput
                            ? () {
                                _searchController.clear();
                                _searchOrders('');
                                FocusScope.of(context).unfocus();
                              }
                            : () {},
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: availableHeight * 0.3,
              child: const Recent(),
            ),
            SizedBox(height: 10),
            if (_filteredOrders.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'No data found',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            if (_filteredOrders.isNotEmpty)
              SizedBox(
                height: availableHeight * 1.7,
                child: OrderList(orders: _filteredOrders),
              ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}