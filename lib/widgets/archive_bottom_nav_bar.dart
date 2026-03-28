import 'package:flutter/material.dart';
import '../core/app_colors.dart';

enum NavTab { home, add, profile }

class ArchiveBottomNavBar extends StatelessWidget {
  final NavTab activeTab;
  final ValueChanged<NavTab> onTabSelected;

  const ArchiveBottomNavBar({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.of(context).navBackground,
        border: Border(
          top: BorderSide(color: AppColors.of(context).divider, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            icon: Icons.chat_bubble_outline_rounded,
            tab: NavTab.home,
            activeTab: activeTab,
            onTap: onTabSelected,
          ),
          // FAB-style centre button
          GestureDetector(
            onTap: () => onTabSelected(NavTab.add),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.of(context).navFab,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: AppColors.of(context).navBackground,
                size: 22,
              ),
            ),
          ),
          _NavItem(
            icon: Icons.person_outline_rounded,
            tab: NavTab.profile,
            activeTab: activeTab,
            onTap: onTabSelected,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final NavTab tab;
  final NavTab activeTab;
  final ValueChanged<NavTab> onTap;

  const _NavItem({
    required this.icon,
    required this.tab,
    required this.activeTab,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = activeTab == tab;
    return GestureDetector(
      onTap: () => onTap(tab),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 52,
        height: 72,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              size: 22,
              color: isActive
                  ? AppColors.of(context).navIconActive
                  : AppColors.of(context).navIconInactive,
            ),
          ),
        ),
      ),
    );
  }
}
