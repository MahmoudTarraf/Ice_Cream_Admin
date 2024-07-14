import 'package:flutter/material.dart';

import '../../../export_screens.dart';

class IceCreamScreeen extends StatefulWidget {
  const IceCreamScreeen({super.key});

  @override
  State<IceCreamScreeen> createState() => _IceCreamScreeenState();
}

class _IceCreamScreeenState extends State<IceCreamScreeen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 150,
        ),
        const Text(
          'Select an action to perform:',
          style: TextStyle(
            fontSize: 26,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 150),
        Padding(
          padding: EdgeInsets.only(left: 50),
          child: Container(
            width: 200,
            // height: 70,
            padding: EdgeInsets.all(7.5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.orange,
                  Colors.red,
                ],
                // begin: Alignment.topLeft,
                // end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.pink,
              borderRadius: BorderRadius.circular(15),
              isExpanded: true,
              underline: Container(),
              alignment: Alignment.center,
              value: 'Add An IceCream',
              onChanged: (String? newValue) {
                if (newValue == 'Add An IceCream') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddIceCream(),
                    ),
                  );
                } else if (newValue == 'Update An IceCream') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchIceCream(),
                    ),
                  );
                } else if (newValue == 'Delete An IceCream') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteIceCream(),
                    ),
                  );
                }
              },
              items: <String>[
                'Add An IceCream',
                'Update An IceCream',
                'Delete An IceCream',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
