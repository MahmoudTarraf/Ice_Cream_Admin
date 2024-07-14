import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/export_providers.dart';
import '../../../export_screens.dart';

// This class uses fancy_bottom_navigation Package
// Link to it :  https://pub.dev/packages/fancy_bottom_navigation

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getAllOrders(
      context,
    );
    super.initState();
  }

  int currentPage = 1;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigationPlus(
        barBackgroundColor: Colors.pink,
        circleColor: Colors.white,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          TabData(
            icon: const Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            title: "Orders",
          ),
          TabData(
            icon: const Icon(
              Icons.percent,
              size: 30,
            ),
            title: "Offers",
          ),
          TabData(
            icon: const Icon(
              Icons.icecream,
              size: 30,
            ),
            title: "Ice Cream",
          )
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const OrdersScreen();
      case 1:
        return const OffersMainScreen();
      default:
        return const IceCreamScreeen();
    }
  }
}
