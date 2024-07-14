import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class IceCreamImage extends StatefulWidget {
  final Function IceCreamImageHandler;
  IceCreamImage({
    super.key,
    required this.IceCreamImageHandler,
  });

  @override
  State<IceCreamImage> createState() => _IceCreamImageState();
}

class _IceCreamImageState extends State<IceCreamImage> {
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      widget.IceCreamImageHandler(
        pickedImageFile,
      );
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }
  }

  Widget _checkIceCreamImage() {
    return Padding(
      padding: EdgeInsets.only(
        left: 60,
        bottom: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.pink,
                ),
              ),
              onPressed: _pickImage,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Select An Image ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            child: _pickedImage != null
                ? Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: FileImage(File(_pickedImage!.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: _pickImage,
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: Center(
                        child: Text(
                          'Tap to choose image',
                          style: Theme.of(context).textTheme.titleLarge,
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
    return _checkIceCreamImage();
  }
}
