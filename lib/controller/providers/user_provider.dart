// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart ' as http;

import '../../model/export_models.dart';
import '../Auth/export_auth.dart';

class UserProvider with ChangeNotifier {
  static const thisUrl = Config.url;
  User _thisUser = User(
    email: 'malk@gmail.com',
    location: 'location',
    userName: 'userName',
    phoneNumber: 'phoneNumber',
  );
  get thisUser => _thisUser;

  setUser({
    required String? email,
    required String location,
    required String phoneNumber,
    required String userName,
  }) {
    _thisUser = User(
      email: email,
      location: location,
      userName: userName,
      phoneNumber: phoneNumber,
    );
  }

  Future<void> getUserDetails(String? email) async {
    final response = await http.get(Uri.parse('${thisUrl}getuser/$email'));
    if (response.statusCode == 200) {
      var selectedData = json.decode(response.body) as Map<String, dynamic>;

      setUser(
          email: email,
          location: selectedData['location'],
          phoneNumber: selectedData['phonenumber'],
          userName: selectedData['username']);

      print(email);
    } else {
      print('Error Retrievind Data! ,Try Again Later ');
    }
    notifyListeners();
  }

  void setUerEmail(String email) {
    _thisUser.email = email;
    notifyListeners();
  }

  get getUserEmail => _thisUser.email;
}
