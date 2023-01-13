import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyAppBarWidget extends StatefulWidget {
  final String titleAppbar;
  const MyAppBarWidget({
    Key? key,
    required this.titleAppbar,
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
      title: Text(
        widget.titleAppbar,
        style: AppTheme.textStyles.titleAppBar,
      ),
      centerTitle: true,
    );
  }
}
