import 'package:flutter/material.dart';
import 'package:quick_bite/constants/colors.dart';

class CustomTextField extends TextFormField {
  CustomTextField({
    super.key,
    this.onChanged,
    this.validator,
    this.icon,
    this.controller,
    this.errorText,
    this.labelText,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.prefixText,
    this.suffixIcon,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.initialValue,
    this.hintText,
  }) : super(
          onChanged: onChanged,
          obscureText: obscureText,
          enabled: enabled,
          validator: validator,
          initialValue: initialValue,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          autovalidateMode: autovalidateMode,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 28 / 24,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: grey),
                borderRadius: BorderRadius.circular(10)),
            suffixIcon: IconButton(
              icon: Icon(suffixIcon),
              onPressed: onSuffixIconPressed,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.black.withOpacity(0.8),
              size: 25,
            ),
            hintText: hintText,
            labelText: enabled ? labelText : null,
            prefix: prefixText != null ? Text(prefixText) : null,
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
          ),
          controller: controller,
        );

  final void Function(String)? onChanged;
  final void Function()? onSuffixIconPressed;
  @override
  final TextEditingController? controller;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  @override
  final AutovalidateMode autovalidateMode;
  final int maxLines;
  final int minLines;
  @override
  final bool enabled;
  final String? prefixText;
  final bool obscureText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final IconData? icon;
  final IconData? suffixIcon;
}
