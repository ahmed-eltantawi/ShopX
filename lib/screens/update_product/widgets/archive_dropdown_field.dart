import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

class ArchiveDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  const ArchiveDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.inputLabel(context)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.of(context).secondaryText),
          dropdownColor: AppColors.of(context).inputBackground,
          style: AppStyles.inputText(context),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppStyles.inputHint(context),
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
        const SizedBox(height: 20),
      ],
    );
  }
}
