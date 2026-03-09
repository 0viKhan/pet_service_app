import 'package:flutter/material.dart';

class ResponsiveHelper {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double smallPhoneBreakpoint = 360;

  // Screen Width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Screen Height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Device Types
  static bool isSmallPhone(BuildContext context) {
    return screenWidth(context) < smallPhoneBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= mobileBreakpoint &&
        screenWidth(context) < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= tabletBreakpoint;
  }

  /// Responsive value selector
  /// Example:
  /// ResponsiveHelper.value(context, mobile: 16, tablet: 32)
  static T value<T>(
      BuildContext context, {
        required T mobile,
        T? tablet,
        T? desktop,
      }) {
    final width = screenWidth(context);

    if (width >= tabletBreakpoint) {
      return desktop ?? tablet ?? mobile;
    }

    if (width >= mobileBreakpoint) {
      return tablet ?? mobile;
    }

    return mobile;
  }
}