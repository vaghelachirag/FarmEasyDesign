import 'package:flutter/material.dart';

class NavigationService{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final currentContext = navigatorKey.currentContext!;
  static final currentState = navigatorKey.currentState!;
}