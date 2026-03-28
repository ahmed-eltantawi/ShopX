import 'package:flutter/material.dart';

class ThemeProvider extends InheritedNotifier<ValueNotifier<ThemeMode>> {
  const ThemeProvider({
    super.key,
    required ValueNotifier<ThemeMode> super.notifier,
    required super.child,
  });

  static ValueNotifier<ThemeMode> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!.notifier!;
  }

  static ThemeMode getTheme(BuildContext context) {
    return of(context).value;
  }

  static void toggleTheme(BuildContext context) {
    final notifier = of(context);
    notifier.value =
        notifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
