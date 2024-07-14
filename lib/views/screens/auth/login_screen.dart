// ignore_for_file: unused_field, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/Auth/export_auth.dart';

// ignore: must_be_immutable
class LogInScreen extends StatefulWidget {
  static const routeName = '/LogInScreen';

  const LogInScreen({super.key});
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool? rememberMe = false;
  @override
  void initState() {
    super.initState();
  }

  String _userName = '';
  String _passWordLogin = '';

  void setUserName(String username) {
    _userName = username;
  }

  void setpasswordLogin(String password1) {
    _passWordLogin = password1;
  }

  final String backImg = 'assets/images/chocolate.png';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var condition = false;
  Future<void> _validateThis(bool? rememberMe) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      condition = true;
    });
    await Provider.of<Validator>(context, listen: false)
        .loginAdmin(
      condition: rememberMe,
      context: context,
      password: _passWordLogin,
      username: _userName,
    )
        .then((value) {
      setState(() {
        condition = false;
      });
    });
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black54,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: kToolbarHeight + 40),
                    const Column(
                      children: <Widget>[
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Signup or Login to continue where you left off !",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      children: [
                        UserName(userNameHandler: setUserName),
                        const SizedBox(
                          height: 20,
                        ),
                        Password(passwordHandler: setpasswordLogin),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                checkColor: Colors.pink,
                                fillColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                value: rememberMe,
                                onChanged: (val) {
                                  setState(() {
                                    rememberMe = val;
                                  });
                                },
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
                              _validateThis(rememberMe);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: condition == true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
