import 'package:flutter/material.dart';

class DeviceUtil {
  static final DeviceUtil _instance = DeviceUtil._internal();
  factory DeviceUtil() => _instance;
  DeviceUtil._internal();

  // Determines if the device is a tablet based on screen width (>600dp)
  bool isTablet(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.shortestSide > 600;
  }

  bool isMobile(BuildContext context) {
    return !isTablet(context);
  }

  // DEVICE ORIENTATIONS
  bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }
}
