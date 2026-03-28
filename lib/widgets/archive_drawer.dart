import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_styles.dart';
import '../core/theme_provider.dart';

class ArchiveDrawer extends StatelessWidget {
  const ArchiveDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeProvider.getTheme(context) == ThemeMode.dark;

    return Drawer(
      backgroundColor: AppColors.of(context).background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'THE ARCHIVE',
                    style: AppStyles.appBarTitle(context).copyWith(fontSize: 14),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.of(context).primaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'PREFERENCES',
                style: AppStyles.eyebrowAccent(context).copyWith(
                  letterSpacing: 4.0,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              title: Text(
                'Dark Luxury Theme',
                style: AppStyles.productName(context),
              ),
              trailing: Switch(
                value: isDark,
                activeColor: AppColors.of(context).accentGold,
                inactiveThumbColor: AppColors.of(context).secondaryText,
                inactiveTrackColor: AppColors.of(context).divider,
                onChanged: (val) {
                  ThemeProvider.toggleTheme(context);
                },
              ),
            ),
            const Spacer(),
            Divider(color: AppColors.of(context).divider, height: 1),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              title: Text(
                'Sign Out',
                style: AppStyles.productName(context).copyWith(
                  color: AppColors.of(context).error,
                ),
              ),
              trailing: Icon(
                Icons.logout,
                color: AppColors.of(context).error,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
