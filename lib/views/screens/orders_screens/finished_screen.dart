import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/export_providers.dart';
import '../../helper/export_helper.dart';

class FinishedScreen extends StatelessWidget {
  const FinishedScreen({super.key});
  static const routeName = '/finished_ooders';
  @override
  Widget build(BuildContext context) {
    final theseOrders =
        Provider.of<OrderProvider>(context, listen: false).getfinishedOrderList;
    print(theseOrders.isEmpty);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<OrderProvider>(context, listen: false)
              .getAllOrders(context);
        },
        child: !theseOrders.isEmpty
            ? OrdersHelper(
                orders: theseOrders,
                condition: false,
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
