// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final String? hintText;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final Function()? onTap;
  final void Function()? onEditingComplete;
  final bool readOnly;
  final bool expands;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final String? Function(String?)? validator;
  final String? value;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final bool autofocus;

  const MyInputWidget({
    Key? key,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.hintText,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.inputFormaters,
    this.onFieldSubmitted,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onEditingComplete,
    this.readOnly = false,
    this.expands = false,
    this.textInputAction,
    this.textAlignVertical = TextAlignVertical.center,
    this.validator,
    this.value,
    this.onSaved,
    this.controller,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: controller == null ? value : null,
      textAlignVertical: textAlignVertical!,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      onEditingComplete: onEditingComplete,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      validator: validator,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      inputFormatters: inputFormaters,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      onSaved: onSaved,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        label: Text(label),
        suffixIcon: suffixIcon,
        filled: true,
        isDense: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade700,
          ),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide(
        //     color: AppTheme.colors.primary,
        //   ),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide(
        //     color: AppTheme.colors.primary,
        //   ),
        // ),
        // labelStyle: const TextStyle(
        //   color: Colors.black87,
        // ),
      ),
    );
  }
}
