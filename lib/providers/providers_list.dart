import 'package:farmlink/providers/auth_provider.dart';
import 'package:farmlink/providers/utility/biometric_provider.dart';
import 'package:farmlink/providers/utility/current_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'categories/category_provider.dart';
import 'farms/farm_provider.dart';
import 'products/products_provider.dart';
import 'utility/bottom_navigation_provider.dart';
import 'utility/image_picker_provider.dart';
import 'utility/language_provider.dart';
import 'utility/app_theme_provider.dart';
import 'utility/location_provider.dart';

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
      _createProvider(() => AuthProvider()),
      _createProvider(() => CurrentPageProvider()),
      _createProvider(() => BiometricProvider()),
      _createProvider(() => FarmProvider()),
      _createProvider(() => CategoryProvider()),
      _createProvider(() => ProductsProvider()),
      _createProvider(() => LocationProvider()),
      _createProvider(() => ImagePickerProvider()),
    ],
    child: child,
  );
}
