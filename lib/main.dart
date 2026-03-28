import 'package:flutter/material.dart';
import 'package:new_shopx/core/app_colors.dart';
import 'package:new_shopx/core/theme_provider.dart';
import 'package:new_shopx/screens/home/home_screen.dart';

void main() {
  runApp(
    ThemeProvider(
      notifier: ValueNotifier(ThemeMode.dark),
      child: const ArchiveApp(),
    ),
  );
}

class ArchiveApp extends StatelessWidget {
  const ArchiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final themeMode = ThemeProvider.getTheme(context);

    return MaterialApp(
      title: 'The Archive',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        scaffoldBackgroundColor: colors.background,
        fontFamily: 'Jost',
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors.accentGold,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: colors.background,
        fontFamily: 'Jost',
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors.accentGold,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
