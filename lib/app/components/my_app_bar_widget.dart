// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/theme/app_theme.dart';

class MyAppBarWidget extends StatefulWidget {
  final String titleAppbar;
  final Widget? backButton;

  const MyAppBarWidget({
    Key? key,
    required this.titleAppbar,
    this.backButton,
  }) : super(key: key);

  @override
  State<MyAppBarWidget> createState() => _MyAppBarWidgetState();
}

class _MyAppBarWidgetState extends State<MyAppBarWidget> {
  final height = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      leading: widget.backButton,
      title: Text(
        widget.titleAppbar,
        style: AppTheme.textStyles.titleAppBar,
      ),
      centerTitle: true,
    );
  }
}
