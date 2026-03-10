import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hasLabel = label.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Text(label, style: medium12),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          style: regular12,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: regular12.copyWith(color: Colors.grey),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: blue1),
            ),
          ),
        ),
      ],
    );
  }
}