// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controller/Auth/export_auth.dart';
import 'controller/providers/export_providers.dart';
import 'export_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  final secureStorage = SecureStorageService();
  final condition = await secureStorage.getCondition();
  runApp(MyApp(
    condition: condition,
  ));
}

class MyApp extends StatelessWidget {
  final String? condition;
  const MyApp({super.key, required this.condition});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Validator(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IceCreamProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OffersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: condition != null ? HomePage() : const LogInScreen(),
      ),
    );
  }
}
