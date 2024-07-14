import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/icecream_add_helper/export_ice_cream_add_helper.dart';
import '../../../controller/providers/export_providers.dart';
import '../../helper/export_helper.dart';

class SearchIceCream extends StatefulWidget {
  const SearchIceCream({super.key});
  static const routeName = '/search_iceCream';

  @override
  State<SearchIceCream> createState() => _SearchIceCreamState();
}

class _SearchIceCreamState extends State<SearchIceCream> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _iceCreamName = '';
  String _iceCreamCategory = '';
  var condition = false;
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

    Provider.of<IceCreamProvider>(context, listen: false)
        .searchIceCream(
      context: context,
      category: _iceCreamCategory,
      title: _iceCreamName,
    )
        .then((value) {
      if (value == true) {
        setState(() {
          condition = true;
        });
      } else if (value == false) {
        showError(context, 'Something Went Wrong!', 'Not Found!');
      }
    });
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
                    name: 'Update An IceCream',
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
                    'Search for IceCream Based on \nname and category:',
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
                Visibility(
                  visible: condition,
                  child: const FlavorCreatorScreen(
                    number: 2,
                    name: 'Update IceCream',
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
