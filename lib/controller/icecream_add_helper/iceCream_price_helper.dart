import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class IceCreamPrice extends StatelessWidget {
  final Function iceCreamHandler;
  final String name;
  IceCreamPrice({
    super.key,
    required this.name,
    required this.iceCreamHandler,
  });
  String _iceCreamPrice = '';
  Widget _checkIceCreamPrice() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$name :',
            style: const TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(31, 156, 149, 149),
              ),
              width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price must\'nt be empty!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _iceCreamPrice = value as String;
                  iceCreamHandler(_iceCreamPrice);
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.numbers,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkIceCreamPrice();
  }
}
