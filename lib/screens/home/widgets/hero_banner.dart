import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

class HeroBanner extends StatelessWidget {
  final String imageUrl;
  final String eyebrow;
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback? onButtonTap;

  const HeroBanner({
    super.key,
    required this.imageUrl,
    this.eyebrow = 'PRODUCT STUDIO',
    this.title = 'Curated Essentialism',
    this.description =
        'A selection of permanent pieces designed to be discerning eye. Authentically cultivable and tasteful profits.',
    this.buttonLabel = 'BROWSE THE STUDIO',
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Background image ─────────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          height: 480,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.of(context).cardBackground,
            ),
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return _HeroShimmer();
            },
          ),
        ),

        // ── Gradient overlay ─────────────────────────────────────────────────
        Container(
          height: 480,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.of(context).primaryText.withOpacity(0.72),
              ],
              stops: const [0.35, 1.0],
            ),
          ),
        ),

        // ── Text content ─────────────────────────────────────────────────────
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eyebrow, style: AppStyles.eyebrowAccent(context)),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: AppStyles.sectionTitle(context).copyWith(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: AppStyles.bodySmall(context).copyWith(
                    color: Colors.white70,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                _BrowseButton(
                  label: buttonLabel,
                  onTap: onButtonTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Hero shimmer placeholder ──────────────────────────────────────────────────
class _HeroShimmer extends StatefulWidget {
  @override
  State<_HeroShimmer> createState() => _HeroShimmerState();
}

class _HeroShimmerState extends State<_HeroShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _anim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
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
    return SizedBox(
      height: 480,
      child: AnimatedBuilder(
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
      ),
    );
  }
}

// ── Browse button ─────────────────────────────────────────────────────────────
class _BrowseButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _BrowseButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Text(
          label,
          style: AppStyles.outlinedButtonLabel(context).copyWith(
            color: Colors.black,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}
