import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/providers/export_providers.dart';
import '../../helper/export_helper.dart';

class UnFinishedScreen extends StatelessWidget {
  const UnFinishedScreen({super.key});
  static const routeName = '/unfinished_ooders';
  @override
  Widget build(BuildContext context) {
    final thoseOrders = Provider.of<OrderProvider>(context).unFinishedOrderList;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<OrderProvider>(context, listen: false)
              .getAllOrders(context);
        },
        child: !thoseOrders.isEmpty
            ? OrdersHelper(
                orders: thoseOrders,
                condition: true,
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "No Orders Yet !",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
