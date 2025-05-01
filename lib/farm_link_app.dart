import 'package:app_links/app_links.dart';
import 'package:farmlink/screens/on_boarding_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'configs/network_interceptor/interceptor.dart';
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
        print('Initial deep link: $initialLink');
        _pendingDeepLink = initialLink.toString();
        // Process after widget tree is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          processPendingDeepLink();
        });
      } else {
        print('No initial deep link');
      }
    } catch (e) {
      print('Error getting initial link: $e');
    }

    // Listen for links when app is running
    _linkSubscription = _appLinks.stringLinkStream.listen((link) {
      print('Stream deep link: $link');
      _pendingDeepLink = link;
      processPendingDeepLink();
    }, onError: (err) {
      print('Error in link stream: $err');
    });
  }

  void _handleDeepLink(String link) {
    print('Handling deep link: $link');
    final uri = Uri.parse(link);
    print('Scheme: ${uri.scheme}'); // farmlinkapp
    print('Host: ${uri.host}'); // activate-account
    print('Path segments: ${uri.pathSegments}'); // [12345]

    if (uri.scheme.toLowerCase() == 'farmlinkapp' &&
        uri.pathSegments.isNotEmpty &&
        uri.host == 'activate-account') {
      print('Deep link matches activate-account scheme');
      final token = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
      if (token != null && _isAppReady()) {
        print('Navigating to activate-account with token: $token');
        _navigatorKey.currentState?.pushNamed(
          FarmLinkRoutes.activateAccount,
          arguments: token,
        );
        return;
      } else {
        print('Token null or app not ready: token=$token, ready=${_isAppReady()}');
      }
    } else {
      print('Deep link does not match farmlinkapp scheme or path');
    }
    // Fallback navigation to onboarding screen
    print('Navigating to onboarding screen (fallback)');
    _navigatorKey.currentState?.pushReplacementNamed(FarmLinkRoutes.onBoardingScreen);
  }

  bool _isAppReady() {
    // Replace with logic to check if app is initialized
    return true; // For now, assume ready
  }

  void processPendingDeepLink() {
    print('Processing pending deep link: $_pendingDeepLink');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pendingDeepLink != null) {
        _handleDeepLink(_pendingDeepLink!);
        _pendingDeepLink = null;
      } else {
        print('No pending deep link, navigating to onboarding');
        _navigatorKey.currentState?.pushReplacementNamed(FarmLinkRoutes.onBoardingScreen);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: SplashScreen(onInitializationComplete: processPendingDeepLink),
      onGenerateRoute: RouteGenerator.generateRoute,
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