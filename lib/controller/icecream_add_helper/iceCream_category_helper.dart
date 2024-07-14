import 'package:flutter/material.dart';

class IceCreamCategory extends StatefulWidget {
  const IceCreamCategory({super.key, required this.IceCreamCategoryHandler});

  @override
  State<IceCreamCategory> createState() => _IceCreamCategoryState();
  final Function IceCreamCategoryHandler;
}

class _IceCreamCategoryState extends State<IceCreamCategory> {
  String _iceCreamCategory = 'Classic Flavors';
  @override
  void initState() {
    widget.IceCreamCategoryHandler(_iceCreamCategory);
    super.initState();
  }

  Widget _chooseIceCreamCategory() {
    return Padding(
      padding: EdgeInsets.only(
        left: 40,
        bottom: 20,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'IceCream Category :',
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 80,
            bottom: 30,
          ),
          child: Container(
            padding: const EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(31, 156, 149, 149),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.white70,
              underline: Container(),
              value: _iceCreamCategory,
              onChanged: (newValue) {
                widget.IceCreamCategoryHandler(_iceCreamCategory);
                setState(() {
                  _iceCreamCategory = newValue as String;

                  widget.IceCreamCategoryHandler(_iceCreamCategory);
                });
              },
              items: <String>[
                'Classic Flavors',
                'Special Desserts',
                'Recently Added',
                'Most Popular',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                );
              }).toList(),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _chooseIceCreamCategory();
  }
}
