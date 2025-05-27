import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../providers/utility/app_theme_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/utility/biometric_provider.dart';
import '../../providers/utility/bottom_navigation_provider.dart';
import '../../providers/utility/language_provider.dart';
import '../../repository/local_storage.dart';
import '../../routes/route_names.dart';
import '../../widgets/profile_list_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer5<AuthProvider, LanguageProvider, AppThemeProvider,
            BiometricProvider, BottomNavigationProvider>(
        builder: (context, profileProvider, languageProvider, appThemeProvider,
            biometricProvider, currentPageProvider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            buildListTile(
              icon: HeroIcons.user,
              iconColor: Theme.of(context).colorScheme.primary,
              title: profileProvider.userData!.firstName +
                  profileProvider.userData!.lastName,
              subtitle: "Full name",
            ),
            buildListTile(
              icon: HeroIcons.envelope,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "${profileProvider.userData?.email}",
              subtitle: "Email address",
            ),
            // if (profileProvider.userData?.accountType == "DEALER")
            //   buildListTile(
            //     icon: HeroIcons.briefcase,
            //     iconColor: Theme.of(context).colorScheme.primary,
            //     title: "Manager",
            //     subtitle: "Role",
            //   ),
            buildListTile(
              icon: HeroIcons.briefcase,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Forum",
              subtitle: "Get Insites and upates from others",
            ),
            buildListTile(
              icon: HeroIcons.briefcase,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "FAQs",
              subtitle: "Get answers to frequently asked questions",
              onTap: () {
                Navigator.pushNamed(context, FarmLinkRoutes.viewFaq);
              },
            ),
            buildListTile(
              icon: HeroIcons.clipboardDocumentCheck,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Financial Inclusion",
              subtitle: "Explore farmers groups and info",
              trailingIcon: HeroIcons.chevronRight,
              onTap: () {
                // Navigator.pushNamed(context, FarmLinkRoutes.report);
              },
            ),
            buildListTile(
              icon: HeroIcons.lockClosed,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Passwords",
              subtitle: "Change your current password",
              trailingIcon: HeroIcons.chevronRight,
              onTap: () {
                Navigator.pushNamed(
                    context, FarmLinkRoutes.changePasswordScreen);
              },
            ),
            buildListTile2(
              icon: HeroIcons.fingerPrint,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Lock Application",
              subtitle: "Enable Biometric lock",
              trailingIcon: Switch.adaptive(
                thumbIcon: WidgetStatePropertyAll(Icon(Icons.shield)),
                value: biometricProvider.isBiometricEnabled,
                onChanged: (bool value) {
                  biometricProvider.handleBiometricToggle(value);
                },
              ),
            ),
            buildListTile(
              icon: HeroIcons.lightBulb,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "App Theme",
              subtitle: "Switch between light and dark theme",
              trailingIcon:
                  appThemeProvider.isDarkMode ? HeroIcons.moon : HeroIcons.sun,
              onTap: () {
                appThemeProvider.toggleTheme();
              },
            ),
            // buildListTile(
            //   icon: HeroIcons.language,
            //   iconColor: Theme.of(context).colorScheme.primary,
            //   title: "Languages",
            //   subtitle:
            //       "Current Language: ${languageProvider.isSwahili ? "Swahili" : "English"}",
            //   trailingIcon: HeroIcons.arrowPathRoundedSquare,
            //   onTap: () {
            //     languageProvider.toggleLanguage();
            //   },
            // ),
            buildListTile(
              icon: HeroIcons.arrowRightStartOnRectangle,
              iconColor: Theme.of(context).colorScheme.error,
              title: "Sign Out",
              titleStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.error),
              subtitle: "Clear session and go out",
              onTap: () async {
                bool? confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      title: Text(
                        "Confirm Sign Out",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                      content: Text("Are you sure you want to sign out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                            onPressed: () async {
                              final session = FlutterSecureStorage();
                              await session.deleteAll();
                              Navigator.of(context).pop(true);
                              currentPageProvider.changeCurrentPage(0);
                              Navigator.pushReplacementNamed(
                                  context, FarmLinkRoutes.loginScreen);
                            },
                            child: Text(
                              "Confirm",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            )),
                      ],
                    );
                  },
                );
                if (confirm == true && context.mounted) {
                  final localStorage = LocalStorage();
                  localStorage.flushStorage().then((_) {
                    currentPageProvider.changeCurrentPage(0);
                  });
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
