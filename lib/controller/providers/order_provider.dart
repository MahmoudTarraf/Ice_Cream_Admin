// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../model/export_models.dart';
import '../Auth/export_auth.dart';
import 'export_providers.dart';

class OrderProvider with ChangeNotifier {
  static const thisurl = Config.url;
  List<OrderModel> _allOrderList = [];
  List<OrderModel> finishedOrderList = [];
  List<OrderModel> unFinishedOrderList = [];
  List<OrderModel> get theseOrders => _allOrderList;

  Future getAllOrders(BuildContext context) async {
    _allOrderList = [];
    final response = await http.get(
      Uri.parse('${thisurl}getAllOrders/'),
      headers: {'Content-Type': 'application/json'},
    );
    final selectedData = json.decode(response.body) as List;
    if (response.statusCode == 200) {
      for (int i = 0; i < selectedData.length; i++) {
        _allOrderList.add(
          OrderModel(
            email: selectedData[i]['email'],
            userName: selectedData[i]['username'],
            phoneNumber: selectedData[i]['phonenumber'],
            location: selectedData[i]['location'],
            operationNumber: selectedData[i]['operationNumber'],
            totalPrice: selectedData[i]['totalPrice'],
            details: selectedData[i]['details'],
            delivered: selectedData[i]['delivered'],
          ),
        );
      }

      setOtherLists(_allOrderList);
    } else {
      showError(context, 'Error!', 'Couldnt get ALl Orders');
    }
    notifyListeners();
  }

  List<OrderModel> get getfinishedOrderList => finishedOrderList;
  List<OrderModel> get getUnFinishedOrderList => unFinishedOrderList;
  //
  void setOtherLists(List orders) {
    finishedOrderList = orders
        .where(
          (element) => element.delivered == "Yes",
        )
        .toList() as List<OrderModel>;
    unFinishedOrderList = orders
        .where(
          (element) => element.delivered == "No",
        )
        .toList() as List<OrderModel>;
    var temp = orders
        .where(
          (element) => element.delivered == "Pending",
        )
        .toList() as List<OrderModel>;
    unFinishedOrderList.addAll(temp);
    notifyListeners();
  }

//
  Future<void> startDelivery({
    required String email,
    required String operationNumber,
    required BuildContext context,
  }) async {
    final response = await http.post(
      Uri.parse('${Config.url}/updateorder/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'operationNumber': operationNumber,
        'delivered': 'MOTHERFUUUUU', //needs auditing
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      showSuccess(context, 'All Done!', 'Delivery Started');
    } else {
      showError(context, 'Error!',
          'Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  int getTotalProfit() {
    int sum = 0;
    finishedOrderList.forEach((element) {
      sum += int.parse(element.totalPrice);
    });
    return sum;
  }
}
