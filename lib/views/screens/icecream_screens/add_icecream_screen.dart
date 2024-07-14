// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/icecream_add_helper/export_ice_cream_add_helper.dart';
import '../../../controller/providers/export_providers.dart';
import '../../../export_screens.dart';
import '../../helper/export_helper.dart';

class AddIceCream extends StatefulWidget {
  const AddIceCream({super.key});
  static const routeName = '/add_iceCream';

  @override
  State<AddIceCream> createState() => _AddIceCreamState();
}

class _AddIceCreamState extends State<AddIceCream> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _iceCreamName = '';
  String _iceCreamCategory = '';
  String _iceCreamDetails = '';
  int _iceCreamPrice = 0;
  late File _image;
  //
  void setIceCreamName(String name) {
    _iceCreamName = name;
  }

  void setIceCreamCategory(String name) {
    _iceCreamCategory = name;
  }

  void setIceCreamDetails(String name) {
    _iceCreamDetails = name;
  }

  void setIceCreamPrice(String price) {
    _iceCreamPrice = int.parse(price);
  }

  void setIceCreamImage(var image) {
    File file = File(image!.path);
    _image = file;
    print('image isss:  $file');
  }

  Future<void> _validateThis() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Show confirmation dialog
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirm Ice Cream Creation',
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
        content: const Text('Are you sure you want to create this ice cream?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Create',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );

    if (isConfirmed != false) {
      Provider.of<IceCreamProvider>(context, listen: false)
          .createIceCream(
            name: _iceCreamName,
            category: _iceCreamCategory,
            context: context,
            details: _iceCreamDetails,
            image: _image,
            price: _iceCreamPrice,
          )
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
          );
    } else {
      print('Ice cream creation cancelled.');
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: SpecialAppBarHelper(
                    name: 'Add An IceCream',
                    color: Colors.black,
                  ),
                ),
                IceCreamName(
                  iceCreamHandler: setIceCreamName,
                ),
                IceCreamCategory(
                  IceCreamCategoryHandler: setIceCreamCategory,
                ),
                IceCreamDetails(
                  iceCreamHandler: setIceCreamDetails,
                ),
                IceCreamPrice(
                  name: 'Price',
                  iceCreamHandler: setIceCreamPrice,
                ),
                IceCreamImage(
                  IceCreamImageHandler: setIceCreamImage,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 80,
                    bottom: 50,
                    top: 20,
                  ),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.pink,
                      ),
                    ),
                    onPressed: _validateThis,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Create IceCream ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
