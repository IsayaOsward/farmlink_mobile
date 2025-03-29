import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme_provider.dart';
import 'bottom_navigation_provider.dart';
import 'language_provider.dart';

// Helper function to create a ChangeNotifierProvider from a class type
ChangeNotifierProvider<T> _createProvider<T extends ChangeNotifier>(
    T Function() creator) {
  return ChangeNotifierProvider<T>(create: (_) => creator());
}

// Export a MultiProvider widget
Widget multiProvider({required Widget child}) {
  return MultiProvider(
    providers: [
      _createProvider(() => LanguageProvider()),
      _createProvider(() => AppThemeProvider()),
      _createProvider(() => BottomNavigationProvider()),
    ],
    child: child,
  );
}
