// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/Auth/validator_auth.dart';
import '../../../controller/add_admin/export_add_admin.dart';
import '../../helper/export_helper.dart';

class AddAdminScreen extends StatefulWidget {
  const AddAdminScreen({super.key});

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  var condition = false;
  String _userName = '';
  String _password = '';
  String _email = '';
  String _phoneNumber = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _validateThis() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      condition = true;
    });
    await Provider.of<Validator>(context, listen: false)
        .createAnAdmin(
            context: context,
            password: _password,
            username: _userName,
            email: _email,
            phoneNumber: _phoneNumber)
        .then((value) {
      setState(() {
        condition = false;
      });
    });
  }

  void setUserName(String username) {
    _userName = username;
  }

  void setPasswordSignup(String password2) {
    _password = password2;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPhoneNumber(String phonenumber) {
    _phoneNumber = phonenumber;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SpecialAppBarHelper(
                  name: "Add an Admin",
                  color: Colors.pink,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: UserNameAdmin(
                    userNameAdminHandler: setUserName,
                  ),
                ),
                Email(
                  emailHandler: setEmail,
                ),
                PhoneNumber(
                  phoneHandler: setPhoneNumber,
                ),
                ReEnterPassword(
                  setReEnterPasswordHandler2: setPasswordSignup,
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      onPrimary: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      _validateThis();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: condition == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Create Admin",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
