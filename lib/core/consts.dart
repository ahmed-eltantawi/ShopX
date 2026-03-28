import 'package:flutter/material.dart';
import 'package:new_shopx/screens/home/home_screen.dart';

abstract class AppConsts {
  static Map<String, WidgetBuilder> routes = {
    HomeScreen.route: (context) => const HomeScreen(),
  };
}
