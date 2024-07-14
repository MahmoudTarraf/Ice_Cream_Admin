// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/export_providers.dart';
import '../../model/export_models.dart';

class OrdersHelper extends StatefulWidget {
  OrdersHelper({
    super.key,
    required this.orders,
    required this.condition,
  });
  List<OrderModel> orders;
  bool condition;

  @override
  State<OrdersHelper> createState() => _OrdersHelperState();
}

class _OrdersHelperState extends State<OrdersHelper> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var thisOrder = widget.orders[index];

        return Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8.0,
                  offset: const Offset(2.0, 4.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to left
              children: [
                itemCreator(
                  'Operation Number:',
                  thisOrder.operationNumber,
                  Colors.pink,
                  true,
                ),
                itemCreator(
                  'UserName:',
                  thisOrder.userName,
                  Colors.black,
                  false,
                ),
                itemCreator(
                  'Email:',
                  thisOrder.email,
                  Colors.black,
                  false,
                ),
                itemCreator(
                  'Phone Number:',
                  thisOrder.phoneNumber,
                  Colors.black,
                  false,
                ),
                itemCreator(
                  'Location:',
                  thisOrder.location,
                  Colors.black,
                  false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Details:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    thisOrder.details,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: itemCreator(
                    'Status :',
                    thisOrder.delivered == "Yes" ? 'Success' : 'Not Delivered',
                    thisOrder.delivered == "Yes" ? Colors.green : Colors.red,
                    true,
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: widget.condition,
                    child: ElevatedButton.icon(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.green,
                        ),
                      ),
                      onPressed: () async {
                        await Provider.of<OrderProvider>(context, listen: false)
                            .startDelivery(
                          email: thisOrder.email,
                          operationNumber: thisOrder.operationNumber,
                          context: context,
                        )
                            .then((value) {
                          setState(() {
                            widget.condition = false;
                          });
                        });
                      },
                      label: const Text(
                        'Start Delivery',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 22,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: widget.orders.length,
    );
  }
}

Widget itemCreator(String title, var value, var color, var condition) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: condition ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
