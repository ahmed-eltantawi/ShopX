import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_styles.dart';

class ArchiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onCartTap;
  final int cartCount;
  final bool isRoot;

  const ArchiveAppBar({
    super.key,
    this.onMenuTap,
    this.onCartTap,
    this.cartCount = 0,
    this.isRoot = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.of(context).background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: (!isRoot && Navigator.canPop(context))
          ? IconButton(
              icon: Icon(Icons.close, color: AppColors.of(context).primaryText),
              onPressed: () => Navigator.pop(context),
              splashRadius: 20,
            )
          : IconButton(
              icon: const _MenuIcon(),
              onPressed: onMenuTap ?? () => Scaffold.of(context).openDrawer(),
              splashRadius: 20,
            ),
      title: Text('THE ARCHIVE', style: AppStyles.appBarTitle(context)),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.of(context).primaryText,
                size: 22,
              ),
              onPressed: onCartTap ?? () {},
              splashRadius: 20,
            ),
            if (cartCount > 0)
              Positioned(
                top: 10,
                right: 8,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).accentGold,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

/// Custom three-line hamburger icon matching the design
class _MenuIcon extends StatelessWidget {
  const _MenuIcon();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _line(context, width: 18),
        const SizedBox(height: 4),
        _line(context, width: 12),
      ],
    );
  }

  Widget _line(BuildContext context, {required double width}) => Container(
        width: width,
        height: 1.5,
        decoration: BoxDecoration(
          color: AppColors.of(context).primaryText,
          borderRadius: BorderRadius.circular(1),
        ),
      );
}
