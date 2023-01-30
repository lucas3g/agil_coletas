// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyElevatedButtonWidget extends StatefulWidget {
  final Widget label;
  final Function()? onPressed;
  final double height;
  final Color? backgroundColor;
  final Color? textButtonColor;
  const MyElevatedButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height = 35,
    this.backgroundColor,
    this.textButtonColor,
  }) : super(key: key);

  @override
  State<MyElevatedButtonWidget> createState() => _MyElevatedButtonWidgetState();
}

class _MyElevatedButtonWidgetState extends State<MyElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.textButtonColor ?? AppTheme.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: widget.label,
      ),
    );
  }
}
