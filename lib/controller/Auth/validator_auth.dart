// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../export_screens.dart';
import '../providers/export_providers.dart';
import 'export_auth.dart';

class Validator with ChangeNotifier {
  static const thisUrl = Config.url;

  Future<void> loginAdmin({
    required String username,
    required String password,
    required BuildContext context,
    required bool? condition,
  }) async {
    const url = '${thisUrl}login_admin';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Admin login successful
      showSuccess(
        context,
        'Welcome',
        'Log in Succesful!',
      );
      if (condition == true) {
        final secureStorage = SecureStorageService();
        await secureStorage.storeCondition("True");
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      showError(context, 'Log in Failed !', '${response.reasonPhrase}');
    }
  }

  Future<void> createAnAdmin({
    required String username,
    required String password,
    required BuildContext context,
    required String email,
    required String phoneNumber,
  }) async {
    //{"username":"ahmad","email":"malk1@gmail.com","password":"123456","phonenumber":"0929837653","location":"arrt"}
    const url = '${thisUrl}createadmin/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        "username": username,
        "email": email,
        "password": password,
        "phonenumber": phoneNumber,
        "location": "Syria"
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Admin login successful
      showSuccess(
        context,
        'All Done!',
        'Admin Created Successfully!',
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      showError(context, 'Admin Creation Failed !', '${response.reasonPhrase}');
    }
  }
}
