// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/export_providers.dart';
import '../../../export_screens.dart';
import '../../../model/export_models.dart';

// ignore: must_be_immutable
class OffersCreatorScreen extends StatelessWidget {
  const OffersCreatorScreen({
    super.key,
    required this.name,
    required this.condition,
  });
  final String name;
  final bool condition;
//
  void deleteOfferNow(
    BuildContext context,
    String title,
    String category,
  ) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirm Offer Deleting',
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
        content: const Text('Are you sure you want to delete this Offer?'),
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
              'delete',
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
      await Provider.of<OffersProvider>(context, listen: false)
          .deleteOffer(
            context: context,
            title: title,
            category: category,
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
      print('Ice cream Updating cancelled.');
    }
  }

//
  @override
  Widget build(BuildContext context) {
    OfferModel offer =
        Provider.of<OffersProvider>(context, listen: false).getOffer;
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(2.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align content to left
          children: [
            Container(
              height: 200,
              child: Image.memory(
                base64Decode(offer.image),
                fit: BoxFit.cover,
              ),
            ),
            itemCreator(
              'Name:',
              offer.title,
              Colors.pink,
              true,
            ),
            itemCreator(
              'Category:',
              offer.category,
              Colors.black,
              true,
            ),
            itemCreator(
              'Price:',
              offer.oldPrice.toString(),
              Colors.black,
              true,
            ),
            const Center(
              child: Text(
                'Details:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                offer.details,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.pink,
                ),
              ),
              onPressed: () {
                if (condition == true) {
                  deleteOfferNow(
                    context,
                    offer.title,
                    offer.category,
                  );
                } else if (condition == false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddOffersScreen(
                        theOffer: offer,
                      ),
                    ),
                  );
                }
              },
              label: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemCreator(String title, var value, var color, var condition) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: condition ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
