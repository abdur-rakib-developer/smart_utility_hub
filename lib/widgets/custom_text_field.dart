import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

// Reusable text field widget for consistent input styling
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.keyboardType,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppConstants.bodyStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppConstants.labelStyle,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppConstants.textSecondaryColor)
            : null,
        errorText: errorText,
        errorStyle: const TextStyle(color: AppConstants.errorColor),
        filled: true,
        fillColor: AppConstants.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(
            color: AppConstants.errorColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
