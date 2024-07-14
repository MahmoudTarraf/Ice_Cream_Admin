import 'package:flutter/material.dart';

import '../../../export_screens.dart';

class OffersMainScreen extends StatefulWidget {
  const OffersMainScreen({super.key});

  @override
  State<OffersMainScreen> createState() => _OffersMainScreenState();
}

class _OffersMainScreenState extends State<OffersMainScreen> {
  var condition = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Select an action to perform:',
            style: TextStyle(
              fontSize: 26,
              color: Colors.pink,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 150),
          Container(
            width: 200,
            // height: 70,
            padding: const EdgeInsets.all(7.5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blue,
                  Color.fromARGB(255, 9, 59, 100),
                ],
                // begin: Alignment.topLeft,
                // end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              isExpanded: true,
              underline: Container(),
              alignment: Alignment.center,
              value: 'Add An Offer',
              onChanged: (String? newValue) {
                if (newValue == 'Add An Offer') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchOffersScreen(),
                    ),
                  );
                  setState(() {
                    condition = true;
                  });
                } else if (newValue == 'Delete An Offer') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteOffersScreen(),
                    ),
                  );
                }
              },
              items: <String>[
                'Add An Offer',
                'Delete An Offer',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
