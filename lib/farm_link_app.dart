import 'package:flutter/material.dart';

import 'configs/network_interceptor/interceptor.dart';
import 'routes/route_generator.dart';
import 'screens/home_pages/profile.dart';

class FarmLinkApp extends StatelessWidget {
  const FarmLinkApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: FarmLinkRoutes.homePage,
      home: Profile(),
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