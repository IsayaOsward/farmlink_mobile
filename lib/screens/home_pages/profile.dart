import 'package:farmlink/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/biometric_provider.dart';
import '../../providers/current_page_provider.dart';
import '../../providers/language_provider.dart';
import '../../repository/session_management.dart';
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
            BiometricProvider, CurrentPageProvider>(
        builder: (context, profileProvider, languageProvider, appThemeProvider,
            biometricProvider, currentPageProvider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            buildListTile(
              icon: HeroIcons.user,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "${profileProvider.userData?['full_name']}",
              subtitle: "Full name",
            ),
            buildListTile(
              icon: HeroIcons.envelope,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "${profileProvider.userData?['email']}",
              subtitle: "Email address",
            ),
            if (profileProvider.userData?['is_manager'] ?? false)
              buildListTile(
                icon: HeroIcons.briefcase,
                iconColor: Theme.of(context).colorScheme.primary,
                title: "Manager",
                subtitle: "Role",
              ),
            buildListTile(
              icon: HeroIcons.phone,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "${profileProvider.userData?['username']}",
              subtitle: "Username",
            ),
            buildListTile(
              icon: HeroIcons.clipboardDocumentCheck,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Report",
              subtitle: "View Monitoring Reports",
              trailingIcon: HeroIcons.chevronRight,
              onTap: () {
                // Navigator.pushNamed(context, FarmLinkRoutes.report);
              },
            ),

            buildListTile(
              icon: HeroIcons.bookOpen,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Regulations",
              subtitle: "View Monitoring Regulations",
              trailingIcon: HeroIcons.chevronRight,
              onTap: () {
                // Navigator.pushNamed(context, FarmLinkRoutes.regulationScreen);
              },
            ),
            buildListTile(
              icon: HeroIcons.lockClosed,
              iconColor: Theme.of(context).colorScheme.primary,
              title: "Passwords",
              subtitle: "Change your current password",
              trailingIcon: HeroIcons.chevronRight,
              onTap: () {
                Navigator.pushNamed(context, FarmLinkRoutes.changePasswordScreen);
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
                            onPressed: () {
                              Navigator.of(context).pop(true);
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
                  SessionManagement.clearSession(context).then((_) {
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
