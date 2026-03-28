import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

/// A labeled text input matching the design's minimal field style.
class ArchiveFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const ArchiveFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefix,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ────────────────────────────────────────────────────────────
        Text(label, style: AppStyles.inputLabel(context)),
        const SizedBox(height: 4),

        // ── Input ────────────────────────────────────────────────────────────
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: AppStyles.inputText(context),
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppStyles.inputHint(context),
            prefixIcon: prefix != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 4, right: 2),
                    child: prefix,
                  )
                : null,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 32, minHeight: 0),
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 12,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.of(context).inputBorder,
                width: 1.0,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.of(context).inputBorder,
                width: 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.of(context).primaryText,
                width: 1.5,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.of(context).error,
                width: 1.0,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
