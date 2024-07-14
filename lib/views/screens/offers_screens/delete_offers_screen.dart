import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/icecream_add_helper/export_ice_cream_add_helper.dart';
import '../../../controller/providers/export_providers.dart';
import '../../../export_screens.dart';
import '../../helper/export_helper.dart';

class DeleteOffersScreen extends StatefulWidget {
  const DeleteOffersScreen({super.key});
  static const routeName = '/delete_offers_screen';

  @override
  State<DeleteOffersScreen> createState() => _DeleteOffersScreenState();
}

class _DeleteOffersScreenState extends State<DeleteOffersScreen> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _iceCreamName = '';
  String _iceCreamCategory = '';
  var firstNumber = 0;
  var secondNumber = 0;
  //
  void setIceCreamName(String name) {
    _iceCreamName = name;
  }

  void setIceCreamCategory(String name) {
    _iceCreamCategory = name;
  }

  Future<void> _validateThis() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    Provider.of<OffersProvider>(context, listen: false)
        .searchOffer(
      context: context,
      title: _iceCreamName,
      category: _iceCreamCategory,
      number: firstNumber,
    )
        .then((value) {
      if (!(value == firstNumber)) {
        print('hereeeeeeeeeeeeeeee + $value, must rebuild');
        setState(() {
          secondNumber = value;
        });
      } else if (value == firstNumber) {
        showError(context, 'Something Went Wrong!', 'Not Found!');
      }
    });
    ;
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
                    name: 'Delete An Offer',
                    color: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 30,
                  ),
                  child: Text(
                    'Search for IceCream Based on \nname and category then Delete Offer:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IceCreamName(
                  iceCreamHandler: setIceCreamName,
                ),
                IceCreamCategory(
                  IceCreamCategoryHandler: setIceCreamCategory,
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
                        'Search For IceCream ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                !(firstNumber == secondNumber)
                    ? const OffersCreatorScreen(
                        condition: true,
                        name: 'Delete Offer',
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
