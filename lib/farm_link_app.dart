import 'package:app_links/app_links.dart';
import 'package:farmlink/screens/on_boarding_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'configs/network_interceptor/interceptor.dart';
import 'configs/theme/theme.dart';
import 'configs/theme/util.dart';
import 'providers/utility/app_theme_provider.dart';
import 'routes/route_generator.dart';
import 'routes/route_names.dart';

class FarmLinkApp extends StatefulWidget {
  const FarmLinkApp({super.key});

  @override
  FarmLinkAppState createState() => FarmLinkAppState();
}

class FarmLinkAppState extends State<FarmLinkApp> {
  final _appLinks = AppLinks();
  StreamSubscription<String>? _linkSubscription;
  String? _pendingDeepLink;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    // Handle initial link when app is opened
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _pendingDeepLink = initialLink.toString();
        // Process after widget tree is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          processPendingDeepLink();
        });
      } else {}
    } catch (e) {}

    // Listen for links when app is running
    _linkSubscription = _appLinks.stringLinkStream.listen((link) {
      _pendingDeepLink = link;
      processPendingDeepLink();
    }, onError: (err) {});
  }

  void _handleDeepLink(String link) {
    final uri = Uri.parse(link);
    // farmlinkapp
    // activate-account
    // [12345]

    if (uri.scheme.toLowerCase() == 'farmlinkapp' &&
        uri.pathSegments.isNotEmpty &&
        uri.host == 'activate-account') {
      final token = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
      if (token != null && _isAppReady()) {
        _navigatorKey.currentState?.pushNamed(
          FarmLinkRoutes.activateAccount,
          arguments: token,
        );
        return;
      } else {}
    } else {}
    // Fallback navigation to onboarding screen
    _navigatorKey.currentState
        ?.pushReplacementNamed(FarmLinkRoutes.onBoardingScreen);
  }

  bool _isAppReady() {
    // Replace with logic to check if app is initialized
    return true; // For now, assume ready
  }

  void processPendingDeepLink() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pendingDeepLink != null) {
        _handleDeepLink(_pendingDeepLink!);
        _pendingDeepLink = null;
      } else {
        _navigatorKey.currentState
            ?.pushReplacementNamed(FarmLinkRoutes.onBoardingScreen);
      }
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: SplashScreen(onInitializationComplete: processPendingDeepLink),
      onGenerateRoute: RouteGenerator.generateRoute,
      darkTheme: theme.dark(),
      theme: theme.light(),
      themeMode: themeProvider.currentTheme,
      builder: (context, child) {
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
            ),
          ],
        );
      },
    );
  }
}
