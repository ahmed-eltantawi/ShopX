import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

class ArtOfEverydaySection extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String body;
  final String bulletOne;
  final String bulletTwo;

  const ArtOfEverydaySection({
    super.key,
    required this.imageUrl,
    this.title = 'The Art of the\nEveryday',
    this.body =
        'We believe objects should be as beautiful as they are functional. Our collection bridges traditional craftsmanship and honor traditional framing archetypes employing expansive innovative information.',
    this.bulletOne = 'LASTING COLLECTIONS',
    this.bulletTwo = 'LIMITED RELEASE',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Full-width image ─────────────────────────────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: AspectRatio(
            aspectRatio: 1.2,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.of(context).cardBackground),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── Title ────────────────────────────────────────────────────────────
        Text(title, style: AppStyles.sectionTitle(context)),
        const SizedBox(height: 14),

        // ── Body ─────────────────────────────────────────────────────────────
        Text(body, style: AppStyles.bodyMedium(context)),
        const SizedBox(height: 20),

        // ── Bullets ──────────────────────────────────────────────────────────
        _Bullet(label: bulletOne),
        const SizedBox(height: 10),
        _Bullet(label: bulletTwo, isAccent: true),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  final String label;
  final bool isAccent;

  const _Bullet({required this.label, this.isAccent = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: isAccent ? AppColors.of(context).accentGold : AppColors.of(context).secondaryText,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: isAccent
              ? AppStyles.eyebrowAccent(context)
              : AppStyles.eyebrow(context).copyWith(color: AppColors.of(context).secondaryText),
        ),
      ],
    );
  }
}
