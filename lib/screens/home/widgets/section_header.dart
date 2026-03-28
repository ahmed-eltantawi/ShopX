import 'package:flutter/material.dart';
import '../../../core/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: AppStyles.sectionTitle(context)),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(actionLabel!, style: AppStyles.linkLabel(context)),
          ),
      ],
    );
  }
}

/// Divider with label, used for "LIMITED RELEASE" etc.
class EyebrowDivider extends StatelessWidget {
  final String label;

  const EyebrowDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(label, style: AppStyles.eyebrow(context)),
      ),
    );
  }
}
