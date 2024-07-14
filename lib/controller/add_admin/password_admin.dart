// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class PasswordAdmin extends StatefulWidget {
  const PasswordAdmin({
    super.key,
    required this.passwordAdminHandler,
  });

  @override
  State<PasswordAdmin> createState() => _PasswordAdminState();
  final Function passwordAdminHandler;
}

class _PasswordAdminState extends State<PasswordAdmin> {
  String _passWordAdmin = '';
  String _passWordAdmins = '';
  bool showPass2 = true;
  String enterPasswordAdminAgain = '';
  String enterPasswordAdminAgains = '';
  bool showPass = true;
  Widget _enterPasswordAdmin(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.white.withOpacity(0.7),
        child: TextFormField(
          obscureText: showPass,
          validator: (value) {
            _passWordAdmins = value as String;
            if (_passWordAdmins.isEmpty) {
              return 'PasswordAdmin must\'nt be empty!';
            }
            if (_passWordAdmins.length < 6) {
              return 'PasswordAdmin is too weak!';
            }
            return null;
          },
          onSaved: (value) {
            _passWordAdmin = _passWordAdmins;
            widget.passwordAdminHandler(_passWordAdmin);
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPass = !showPass;
                });
              },
              icon: showPass
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            icon: const Icon(Icons.lock),
            hintText: "PasswordAdmin",
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
    return _enterPasswordAdmin(context);
  }
}
