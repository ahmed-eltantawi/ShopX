import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

import 'dart:typed_data';

class ProductImagePreview extends StatelessWidget {
  final String imageUrl;
  final String? quote;
  final Uint8List? localImageBytes;

  const ProductImagePreview({
    super.key,
    required this.imageUrl,
    this.localImageBytes,
    this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Product image ─────────────────────────────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: AspectRatio(
            aspectRatio: 1.15,
            child: localImageBytes != null
                ? Image.memory(
                    localImageBytes!,
                    fit: BoxFit.contain,
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.of(context).cardBackground,
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.of(context).hintText,
                    size: 40,
                  ),
                ),
              ),
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return _ImageShimmer();
              },
            ),
          ),
        ),

        // ── Quote overlay at the bottom ────────────────────────────────────
        if (quote != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Container(
                color: AppColors.of(context).primaryText.withOpacity(0.9),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Text(quote!, style: AppStyles.quote(context)),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Animated shimmer for image load ──────────────────────────────────────────
class _ImageShimmer extends StatefulWidget {
  @override
  State<_ImageShimmer> createState() => _ImageShimmerState();
}

class _ImageShimmerState extends State<_ImageShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = AppColors.of(context).cardBackground;
    final highlight = AppColors.of(context).overlayBackground;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 0.5, 0),
            end: Alignment(_anim.value + 0.5, 0),
            colors: [base, highlight, base],
          ),
        ),
      ),
    );
  }
}
