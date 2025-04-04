import 'package:farmlink/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  HeroIcon(
                    HeroIcons.userCircle,
                    size: 50,
                  ),
                  Text(
                    "FUll name",
                  ),
                  Text("User email")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.green,
                  leading: HeroIcon(
                    HeroIcons.userCircle,
                  ),
                  title: Text(
                    "Profile",
                  ),
                  trailing: HeroIcon(
                    HeroIcons.arrowRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.green,
                  leading: HeroIcon(
                    HeroIcons.userCircle,
                  ),
                  title: Text(
                    "Settings",
                  ),
                  trailing: HeroIcon(
                    HeroIcons.arrowRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.green,
                  leading: HeroIcon(
                    HeroIcons.userCircle,
                  ),
                  title: Text(
                    "Help & Support",
                  ),
                  trailing: HeroIcon(
                    HeroIcons.arrowRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.green,
                  leading: HeroIcon(
                    HeroIcons.userCircle,
                  ),
                  title: Text(
                    "Log out",
                  ),
                  trailing: HeroIcon(
                    HeroIcons.arrowRight,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
