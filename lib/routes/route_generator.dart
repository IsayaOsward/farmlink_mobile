import 'package:farmlink/screens/faq/view_faq.dart';
import 'package:flutter/material.dart';

import '../screens/authentication/activate_account.dart';
import '../screens/authentication/change_password.dart';
import '../screens/authentication/login.dart';
import '../screens/authentication/registration.dart';
import '../screens/authentication/reset_password.dart';
import '../screens/faq/create_faq.dart';
import '../screens/home_pages/chat_page.dart';
import '../screens/home_pages/main_page.dart';
import '../screens/on_boarding_screen/welcome_page.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    // Define routes map
    final Map<String, Widget Function(BuildContext, dynamic)> routes = {
      FarmLinkRoutes.loginScreen: (_, __) => Login(),
      FarmLinkRoutes.passwordResetScreen: (_, __) => ResetPassword(),
      FarmLinkRoutes.registrationScreen: (_, __) => Registration(),
      FarmLinkRoutes.changePasswordScreen: (_, __) => ChangePassword(),
      FarmLinkRoutes.chatScreen: (_, __) => ChatPage(),
      FarmLinkRoutes.homePage: (_, __) => MainScreen(),
      FarmLinkRoutes.onBoardingScreen: (_, __) => OnboardingScreen(),
      FarmLinkRoutes.viewFaq: (_, __) => ViewFaq(),
    };

    // Route for ActivateAccount where token is passed as an argument
    if (settings.name == FarmLinkRoutes.activateAccount) {
      final token = args as String?;
      if (token != null) {
        return MaterialPageRoute(
          builder: (context) => ActivateAccount(token: token),
        );
      }
    }

    // If route is found in the map, return the corresponding route
    final routeBuilder = routes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(
        builder: (context) => routeBuilder(context, args),
      );
    }

    // Fallback for unknown routes
    return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
