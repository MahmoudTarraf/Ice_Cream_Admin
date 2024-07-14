import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IceCreamName extends StatelessWidget {
  final Function iceCreamHandler;
  IceCreamName({
    super.key,
    required this.iceCreamHandler,
  });
  String _iceCreamName = '';
  Widget _checkIceCreamName() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(
              10,
            ),
            child: Text(
              'IceCream Name:',
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(31, 156, 149, 149),
                ),
                width: 320,
                height: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  // ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'IceCream Name must\'nt be empty!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _iceCreamName = value as String;
                    iceCreamHandler(_iceCreamName);
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.icecream),
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
    return _checkIceCreamName();
  }
}
