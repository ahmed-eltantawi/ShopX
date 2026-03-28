import 'package:flutter/material.dart';
import 'package:new_shopx/models/product_model.dart';
import 'package:new_shopx/services/get_all_products.dart';
import 'package:new_shopx/services/get_category_products.dart';
import '../../core/app_colors.dart';
import '../../core/app_styles.dart';
import '../../widgets/archive_drawer.dart';
import '../../widgets/archive_app_bar.dart';
import '../../widgets/archive_bottom_nav_bar.dart';
import '../update_product/update_product_screen.dart';
import 'widgets/hero_banner.dart';
import 'widgets/product_card.dart';
import 'widgets/section_header.dart';
import 'widgets/art_of_everyday_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String route = "HomeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _baseUrl =
      'https://sandbox.mockerito.com/ecommerce/api/products';

  NavTab _activeTab = NavTab.home;

  // API service instances
  final _getAllProducts = GetAllProducts();
  final _getCategoryProducts = GetCategoryProducts();

  late Future<List<ProductModel>> _allProductsFuture;
  late Future<List<ProductModel>> _limitedReleaseFuture;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    _allProductsFuture = _getAllProducts.getAllProducts(url: _baseUrl);
    _limitedReleaseFuture = _getCategoryProducts.getCategoryProducts(
      categoryName: 'electronics',
    );
  }

  Future<void> _refresh() async {
    setState(() => _fetchData());
    await Future.wait([_allProductsFuture, _limitedReleaseFuture]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      drawer: const ArchiveDrawer(),
      appBar: const ArchiveAppBar(cartCount: 2, isRoot: true),
      bottomNavigationBar: ArchiveBottomNavBar(
        activeTab: _activeTab,
        onTabSelected: (tab) {
          if (tab == NavTab.add) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => const UpdateProductScreen(product: null),
            );
          } else {
            setState(() => _activeTab = tab);
          }
        },
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: RefreshIndicator(
            onRefresh: _refresh,
            color: AppColors.of(context).buttonDark,
            backgroundColor: AppColors.of(context).cardBackground,
            strokeWidth: 1.5,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── Hero banner ───────────────────────────────────────────────────
                FutureBuilder<List<ProductModel>>(
                  future: _allProductsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final firstProduct = snapshot.data!.first;
                      return SliverToBoxAdapter(
                        child: HeroBanner(
                          imageUrl: firstProduct.image,
                          title: firstProduct.title,
                          description: firstProduct.description,
                          onButtonTap: () {},
                        ),
                      );
                    }
                    // Show animated shimmer instead of blank void while loading
                    return const SliverToBoxAdapter(child: _HeroShimmerPlaceholder());
                  },
                ),

                // ── Latest Arrivals ───────────────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(title: 'All Products'),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  sliver: FutureBuilder<List<ProductModel>>(
                    future: _allProductsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(child: _LoadingShimmer());
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return SliverToBoxAdapter(
                          child: _ErrorTile(message: snapshot.error.toString()),
                        );
                      }
                      final products = snapshot.data!;

                      if (products.isEmpty) {
                        return const SliverToBoxAdapter(child: SizedBox());
                      }

                      return SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 28,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.51,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ProductCard(
                            imageUrl: products[index].image,
                            name: products[index].title,
                            price: products[index].price,
                            onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (_) => UpdateProductScreen(
                                product: products[index],
                              ),
                            ),
                          ),
                          childCount: products.length,
                        ),
                      );
                    },
                  ),
                ),

                // ── Art of the Everyday ───────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: ArtOfEverydaySection(
                      imageUrl:
                          'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=800',
                    ),
                  ),
                ),

                // ── LIMITED RELEASE divider ───────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                  sliver: const SliverToBoxAdapter(
                    child: EyebrowDivider(label: 'LIMITED RELEASE'),
                  ),
                ),

                // ── Limited release products ──────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: FutureBuilder<List<ProductModel>>(
                    future: _limitedReleaseFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(child: _LoadingShimmer());
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return SliverToBoxAdapter(
                          child: _ErrorTile(message: snapshot.error.toString()),
                        );
                      }
                      final products = snapshot.data!;
                      return SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 28,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.51,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ProductCard(
                            imageUrl: products[index].image,
                            name: products[index].title,
                            price: products[index].price,
                            onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (_) => UpdateProductScreen(
                                product: products[index],
                              ),
                            ),
                          ),
                          childCount: products.length,
                        ),
                      );
                    },
                  ),
                ),

                // ── Bottom padding ────────────────────────────────────────────
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Internal helpers ──────────────────────────────────────────────────────────

// ── Hero shimmer placeholder — shown instead of blank void during data load ───
class _HeroShimmerPlaceholder extends StatefulWidget {
  const _HeroShimmerPlaceholder();

  @override
  State<_HeroShimmerPlaceholder> createState() => _HeroShimmerPlaceholderState();
}

class _HeroShimmerPlaceholderState extends State<_HeroShimmerPlaceholder>
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
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        height: 480,
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

// ── Animated section shimmer skeleton ────────────────────────────────────────
class _LoadingShimmer extends StatefulWidget {
  const _LoadingShimmer();

  @override
  State<_LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<_LoadingShimmer>
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
    _anim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _shimmerBox({double? width, required double height}) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, __) {
        final base = AppColors.of(context).cardBackground;
        final highlight = AppColors.of(context).overlayBackground;
        return Container(
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(_anim.value - 0.5, 0),
              end: Alignment(_anim.value + 0.5, 0),
              colors: [base, highlight, base],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(height: 320),
              const SizedBox(height: 10),
              _shimmerBox(width: 180, height: 12),
              const SizedBox(height: 6),
              _shimmerBox(width: 60, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorTile extends StatelessWidget {
  final String message;
  const _ErrorTile({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.of(context).error.withOpacity(0.07),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Failed to load products.\n$message',
        style: AppStyles.bodySmall(context).copyWith(color: AppColors.of(context).error),
      ),
    );
  }
}
