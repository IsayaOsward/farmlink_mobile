import 'package:farmlink/screens/authentication/login.dart';
import 'package:farmlink/screens/home_pages/main_page.dart';
import 'package:farmlink/screens/on_boarding_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'configs/network_interceptor/interceptor.dart';
import 'routes/route_generator.dart';
import 'routes/route_names.dart';

class FarmLinkApp extends StatelessWidget {
  const FarmLinkApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (
        context,
        child,
      ) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (_) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    NetworkInterceptor().init(context);
                  },
                );
                return child!;
              },
            )
          ],
        );
      },
    );
  }
}