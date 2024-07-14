// ignore_for_file: use_build_context_synchronously, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/export_models.dart';
import '../Auth/export_auth.dart';
import 'export_providers.dart';

class OffersProvider with ChangeNotifier {
  //
  OfferModel _thisOffer = OfferModel(
    id: 0,
    category: "",
    details: "",
    image: "",
    title: "",
    oldPrice: 0,
    newPrice: 0,
  );
  OfferModel get getOffer => _thisOffer;

  //
  Future<void> createOffer({
    required BuildContext context,
    required OfferModel thisOffer,
    required int newPrice,
  }) async {
    final bool condition = await searchForCreate(
      context: context,
      title: thisOffer.title,
      category: thisOffer.category,
    );
    if (!condition) {
      print('new price: $newPrice');
      var body = {
        "title": thisOffer.title,
        "details": thisOffer.details,
        "category": thisOffer.category,
        "oldPrice": thisOffer.oldPrice.toString(),
        "newPrice": newPrice.toString(),
        "image": thisOffer.image
      };
      final response = await http.post(
        Uri.parse('${Config.url}createoffer/'),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );
      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess(context, 'All Done!', 'Created Offer Successfully!');
      } else {
        showError(context, 'Something Went Wrong!', '${response.reasonPhrase}');
      }
    } else {
      showError(context, 'Error!', 'Offer Already Made!');
    }
    notifyListeners();
  }

  Future<void> deleteOffer({
    required BuildContext context,
    required String title,
    required String category,
  }) async {
    print('_______________');
    print(title);
    print(category);
    print('___________________');
    final response = await http.delete(
      Uri.parse('${Config.url}deleteoffer/'),
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

  Future<int> searchOffer({
    required BuildContext context,
    required String title,
    required String category,
    required int number,
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
      _thisOffer = OfferModel(
        id: responseData["id"],
        category: responseData["category"],
        details: responseData["details"],
        image: responseData["image"],
        title: responseData["title"],
        oldPrice: int.parse(responseData["price"]),
        newPrice: 0,
      );

      notifyListeners();
      return number + 1;
    } else {
      showError(context, 'Something Went Wrong!', '${response.reasonPhrase}');
      return number;
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
      Uri.parse('${Config.url}searchoffer/'),
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
