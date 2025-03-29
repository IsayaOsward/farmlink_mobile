import 'package:flutter/material.dart';

import '../screens/authentication/change_password.dart';
import '../screens/authentication/login.dart';
import '../screens/authentication/registration.dart';
import '../screens/authentication/reset_password.dart';
import '../screens/home_pages/chat_page.dart';
import '../screens/home_pages/home_page.dart';
import '../screens/welcome/spash.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    final Map<String, Widget Function(BuildContext, dynamic)> routes = {
      FarmLinkRoutes.splashScreen: (_, __) => SplashScreen(),
      FarmLinkRoutes.loginScreen: (_, __) => Login(),
      FarmLinkRoutes.passwordResetScreen: (_, __) => ResetPassword(),
      FarmLinkRoutes.registrationScreen: (_, __) => Registration(),
      FarmLinkRoutes.onBoardingScreen: (_, __) => ChangePassword(),
      FarmLinkRoutes.chatScreen: (_, __) => ChatPage(),
      FarmLinkRoutes.homePage: (_, __) => HomePage(),
    };

    final routeBuilder = routes[settings.name];

    if (routeBuilder != null) {
      return MaterialPageRoute(
        builder: (context) => routeBuilder(context, args),
      );
    }

    return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
