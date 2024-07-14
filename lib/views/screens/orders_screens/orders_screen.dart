import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/export_providers.dart';
import '../../../export_screens.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  // Create TabController instance
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getOrders();
    _tabController =
        TabController(length: 2, vsync: this); // Initialize TabController
  }

  Future<void> _getOrders() async {
    await Provider.of<OrderProvider>(context, listen: false)
        .getAllOrders(context);
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose of TabController when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Match TabController length
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Center(child: Text('Orders!')), // Adjusted title
          bottom: TabBar(
            controller: _tabController, // Use TabController
            tabs: const [
              Tab(icon: Icon(Icons.check_circle), text: 'Finished'),
              Tab(icon: Icon(Icons.access_time), text: 'Unfinished'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController, // Use TabController
          children: const [
            FinishedScreen(),
            UnFinishedScreen(),
          ],
        ),
      ),
    );
  }
}
