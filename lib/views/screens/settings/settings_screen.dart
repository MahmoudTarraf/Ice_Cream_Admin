import 'package:flutter/material.dart';

import '../../../controller/Auth/export_auth.dart';
import '../../../export_screens.dart';
import '../../helper/export_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SpecialAppBarHelper(
              name: "Settings",
              color: Colors.pink,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfitsScreen(),
                  ),
                );
              },
              child: itemCreatot(
                context: context,
                title: "Profits",
                subTitle: "see profits now !",
                icon: Icons.forward,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAdminScreen(),
                  ),
                );
              },
              child: itemCreatot(
                context: context,
                title: "Add Admin",
                subTitle: "add admin !",
                icon: Icons.add,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final secureStorage = SecureStorageService();
                await secureStorage.storeCondition("");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ),
                );
              },
              child: itemCreatot(
                context: context,
                title: "Logout",
                subTitle: "logout now",
                icon: Icons.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemCreatot({
  required BuildContext context,
  required String title,
  required String subTitle,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
    child: ListTile(
      title: Text(
        textDirection: TextDirection.ltr,
        title,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        textDirection: TextDirection.ltr,
        subTitle,
      ),
      trailing: Icon(
        textDirection: TextDirection.ltr,
        icon,
        color: Colors.pink,
      ),
    ),
  );
}
