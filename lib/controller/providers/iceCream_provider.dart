// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/export_models.dart';
import '../Auth/export_auth.dart';
import 'export_providers.dart';

class IceCreamProvider with ChangeNotifier {
  IceCream _thisIcecream = IceCream(
    id: 0,
    category: "",
    details: "",
    image: "",
    title: "",
    price: 0,
  );
  IceCream get getIceCream => _thisIcecream;
  //
  Future<void> createIceCream({
    required BuildContext context,
    required String name,
    required String details,
    required String category,
    required int price,
    required File image,
  }) async {
    final bool condition = await searchForCreate(
        context: context, title: name, category: category);
    if (!condition) {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      var body = {
        "title": name,
        "details": details,
        "category": category,
        "price": price.toString(),
        "image": base64Image.toString(),
      };
      final response = await http.post(
        Uri.parse('${Config.url}createicecream/'),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );
      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess(context, 'All Done!', 'Created IceCream Successfully!');
      } else {
        showError(context, 'Error!', '${response.reasonPhrase}');
      }
    } else {
      showError(context, 'Error!', 'This Item Already Craeted!');
    }
    notifyListeners();
  }

  //

  Future<bool> searchIceCream({
    required BuildContext context,
    required String title,
    required String category,
  }) async {
    var body = {
      "title": title,
      "category": category,
    };
    final response = await http.post(
      Uri.parse('${Config.url}searchicecream/'),
      body: body,
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      _thisIcecream = IceCream(
        id: responseData["id"],
        category: responseData["category"],
        details: responseData["details"],
        image: responseData["image"],
        title: responseData["title"],
        price: int.parse(responseData["price"]),
      );

      notifyListeners();
      return true;
    } else {
      showError(context, 'Something Went Wrong!', '${response.reasonPhrase}');
      return false;
    }
  }

  Future<void> updateIceCream({
    required BuildContext context,
    required int iceCreamId,
    required Map<String, dynamic> newData,
  }) async {
    final response = await http.put(
      Uri.parse('${Config.url}updateicecream/$iceCreamId/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newData),
    );

    if (response.statusCode == 200) {
      showSuccess(context, 'All Done!', 'IceCream Updated Succefully!');
    } else {
      showError(context, 'Something Went Wrong!', '${response.reasonPhrase}');
    }
  }

  Future<void> deleteIceCream({
    required BuildContext context,
    required String title,
    required String category,
  }) async {
    final response = await http.post(
      Uri.parse('${Config.url}deleteicecream/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'title': title,
          'category': category,
        },
      ),
    );

    if (response.statusCode == 200) {
      showSuccess(context, 'All Done!', 'IceCream Deleted Succefully!');
    } else {
      showError(context, 'Something Went Wrong!', '${response.reasonPhrase}');
    }
  }

  Future<bool> searchForCreate({
    required BuildContext context,
    required String title,
    required String category,
  }) async {
    var body = {
      "title": title,
      "category": category,
    };
    final response = await http.post(
      Uri.parse('${Config.url}searchicecream/'),
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
