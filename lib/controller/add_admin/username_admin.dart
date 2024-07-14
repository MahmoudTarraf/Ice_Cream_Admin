import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class UserNameAdmin extends StatelessWidget {
  final Function userNameAdminHandler;
  UserNameAdmin({
    super.key,
    required this.userNameAdminHandler,
  });
  String _userNameAdmin = '';
  Widget _checkUserNameAdmin(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        color: Colors.white.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            _userNameAdmin = value as String;
            userNameAdminHandler(_userNameAdmin);
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            hintText: "User Name",
            hintStyle: const TextStyle(
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
    return _checkUserNameAdmin(context);
  }
}
