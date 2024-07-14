import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class UserName extends StatelessWidget {
  final Function userNameHandler;
  UserName({
    super.key,
    required this.userNameHandler,
  });
  String _userName = '';
  Widget _checkUserName() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        color: Colors.white.withOpacity(0.7),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username must\'nt be empty!';
            }
            return null;
          },
          onSaved: (value) {
            _userName = value as String;
            userNameHandler(_userName);
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'User Name',
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkUserName();
  }
}