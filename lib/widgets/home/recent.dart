import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/home/delivered_order.dart';
import 'package:mobile_app/widgets/home/pending_order.dart';

class Recent extends StatelessWidget {
  const Recent({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Recent ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                //   TextButton(
                //     onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>  const OrderPage(),
                //     ),
                //   );
                // },
                //     child: const Text(
                //       'See All',
                //       style: TextStyle(color: Colors.black),
                //     ),
                //   ),
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PendingOrder(orders: [],),
                        ),);
                      },
                      child: const BoxWidget(
                        number: '10',
                        text: 'Pending',
                        icon: Icons.pending_actions_outlined,
                        iconColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 158, 158, 158),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeliveredOrder(orders: [],),
                        ),);
                      },
                      child: const BoxWidget(
                        number: '22',
                        text: 'Delivered',
                        icon: Icons.local_shipping_outlined,
                        iconColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 173, 121, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final String number;
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;

  const BoxWidget({
    Key? key,
    required this.number,
    required this.text,
    required this.icon,
    required this.iconColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: const TextStyle(
                fontSize: 41, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
