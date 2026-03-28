import 'package:flutter/material.dart';
import 'package:new_shopx/models/product_model.dart';
import 'package:new_shopx/services/add_product.dart';
import 'package:new_shopx/services/update_product.dart';
import '../../core/app_colors.dart';
import '../../core/app_styles.dart';
import '../../widgets/archive_app_bar.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'widgets/archive_dropdown_field.dart';
import 'widgets/archive_form_field.dart';
import 'widgets/product_image_preview.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel? product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _imageUrlController;
  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;

  // Current preview URL (updates live as user types)
  late String _previewImageUrl;
  Uint8List? _localImageBytes;
  String? _localImageFileName;

  String _selectedCategory = 'electronics';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _imageUrlController = TextEditingController(text: p?.image ?? '');
    _titleController = TextEditingController(text: p?.title ?? '');
    _priceController = TextEditingController(
        text: p != null ? p.price.toString() : '');
    _descriptionController = TextEditingController(text: p?.description ?? '');

    _previewImageUrl = p?.image ?? '';
    if (p != null) {
      _selectedCategory = p.category;
    }
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: const ArchiveAppBar(
        cartCount: 2,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Eyebrow + Title ──────────────────────────────────────────
              Text('INVENTORY MANAGEMENT', style: AppStyles.eyebrow(context)),
              const SizedBox(height: 10),
              _SplitTitle(
                normal: widget.product == null ? 'Expand the ' : 'Refine the ',
                italic: 'Collection',
              ),
              const SizedBox(height: 28),

              // ── Image preview ────────────────────────────────────────────
              ProductImagePreview(
                imageUrl: _previewImageUrl,
                localImageBytes: _localImageBytes,
              ),
              const SizedBox(height: 12),

              // ── Select image button ──────────────────────────────────────
              _GalleryButton(onTap: _pickImage),

              const SizedBox(height: 24),

              ArchiveFormField(
                label: 'IMAGE URL',
                hint: 'https://...',
                controller: _imageUrlController,
                keyboardType: TextInputType.url,
                onChanged: (val) {
                  if (val.startsWith('http')) {
                    setState(() {
                      _previewImageUrl = val;
                      _localImageBytes = null; // Clear local image if URL is pasted
                      _localImageFileName = null;
                    });
                  }
                },
                validator: (val) =>
                    (_localImageBytes == null && (val == null || val.isEmpty))
                        ? 'Required'
                        : null,
              ),

              ArchiveFormField(
                label: 'TITLE',
                hint: 'Heritage Silk Scarf',
                controller: _titleController,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Required' : null,
              ),

              ArchiveFormField(
                label: 'PRICE',
                hint: '1250.00',
                controller: _priceController,
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                prefix: Text('\$', style: AppStyles.pricePrefix(context)),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (double.tryParse(val) == null) return 'Enter a valid price';
                  return null;
                },
              ),

              ArchiveFormField(
                label: 'DESCRIPTION',
                hint: 'Exquisite craftsmanship meeting\ncontemporary silhouettes.',
                controller: _descriptionController,
                maxLines: 4,
              ),

              if (widget.product == null) ...[
                ArchiveDropdownField(
                  label: 'CATEGORY',
                  hint: 'Select Category',
                  value: _selectedCategory,
                  items: const [
                    'electronics',
                    "men's clothing",
                    "women's clothing"
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedCategory = val);
                    }
                  },
                ),
              ],

              const SizedBox(height: 8),

              // ── Submit button ────────────────────────────────────────────
              _UpdateButton(
                label: widget.product == null ? 'ADD PRODUCT' : 'UPDATE PRODUCT',
                isLoading: _isLoading,
                onTap: _submit,
              ),

              const SizedBox(height: 32),

              // ── Footer meta ──────────────────────────────────────────────
              if (widget.product != null)
                _FooterMeta(productId: widget.product!.id),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }

  // ── Logic ─────────────────────────────────────────────────────────────────

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _localImageBytes = bytes;
        _localImageFileName = pickedFile.name;
        // Do not clear _imageUrlController in case they want to keep the old URL around,
        // but the bytes will take precedence in the preview via ProductImagePreview logic.
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final updatedProduct = ProductModel(
      id: widget.product?.id ?? 0,
      title: _titleController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      description: _descriptionController.text.trim(),
      image: _localImageFileName ?? _imageUrlController.text.trim(),
      category: _selectedCategory,
      rating: widget.product?.rating ?? const RatingModel(rate: 0, count: 0),
    );

    try {
      if (widget.product != null) {
        await UpdateProductService().updateProduct(
          id: widget.product!.id,
          product: updatedProduct,
          context: context,
        );
      } else {
        await AddProduct().addProduct(
            url: "https://sandbox.mockerito.com/ecommerce/api/products",
            product: updatedProduct,
          );
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully!')),
            );
            Navigator.pop(context);
          }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────

class _SplitTitle extends StatelessWidget {
  final String normal;
  final String italic;

  const _SplitTitle({required this.normal, required this.italic});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: normal, style: AppStyles.heroTitle(context)),
          TextSpan(text: italic, style: AppStyles.heroTitleItalic(context)),
        ],
      ),
    );
  }
}

// ── Gallery picker button ────────────────────────────────────────────────────
class _GalleryButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GalleryButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.of(context).buttonDark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: accent, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_rounded, size: 16, color: accent),
            const SizedBox(width: 10),
            Text(
              'UPLOAD IMAGE',
              style: AppStyles.buttonLabel(context).copyWith(color: accent),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpdateButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;

  const _UpdateButton({
    required this.label,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: isLoading
              ? AppColors.of(context).buttonDark.withOpacity(0.6)
              : AppColors.of(context).buttonDark,
          borderRadius: BorderRadius.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.of(context).buttonText,
                ),
              )
            else ...[
              Text(label, style: AppStyles.buttonLabel(context)),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward,
                color: AppColors.of(context).buttonText,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FooterMeta extends StatelessWidget {
  final int productId;
  const _FooterMeta({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sync indicator dot
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.of(context).success,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('LAST SYNCED', style: AppStyles.metaLabel(context)),
              Text('2 MINUTES AGO', style: AppStyles.metaValue(context)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ARCHIVE REFERENCE', style: AppStyles.metaLabel(context)),
            Text(
              '#${productId.toString().padLeft(3, '0')}A-INV',
              style: AppStyles.metaValue(context),
            ),
          ],
        ),
      ],
    );
  }
}
