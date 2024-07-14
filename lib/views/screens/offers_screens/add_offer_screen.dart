import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/icecream_add_helper/export_ice_cream_add_helper.dart';
import '../../../controller/providers/export_providers.dart';
import '../../../export_screens.dart';
import '../../../model/export_models.dart';
import '../../helper/export_helper.dart';

class AddOffersScreen extends StatefulWidget {
  const AddOffersScreen({super.key, required this.theOffer});
  static const routeName = '/add_offer_screen';
  final OfferModel theOffer;
  @override
  State<AddOffersScreen> createState() => _AddOffersScreenState();
}

class _AddOffersScreenState extends State<AddOffersScreen> {
  //
  int _newPrice = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  void setIceCreamPrice(String newPrice) {
    _newPrice = int.parse(newPrice);
  }

  Future<void> _validateThis(OfferModel thisOffer) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    Provider.of<OffersProvider>(context, listen: false)
        .createOffer(
          context: context,
          thisOffer: thisOffer,
          newPrice: _newPrice,
        )
        .then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          ),
        );
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
                    name: 'Create An Offer',
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: IceCreamPrice(
                      name: 'New Price', iceCreamHandler: setIceCreamPrice),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 100,
                    bottom: 50,
                    top: 60,
                  ),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.pink,
                      ),
                    ),
                    onPressed: () => _validateThis(
                      widget.theOffer,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Create Offer',
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
