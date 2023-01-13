// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyAlertDialogWidget extends StatefulWidget {
  final String title;
  final String content;
  final Widget? okButton;
  final Widget? cancelButton;

  const MyAlertDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    this.okButton,
    this.cancelButton,
  }) : super(key: key);

  @override
  State<MyAlertDialogWidget> createState() => _MyAlertDialogWidgetState();
}

class _MyAlertDialogWidgetState extends State<MyAlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 8,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Código de Autenticação',
            style: AppTheme.textStyles.titleAlertDialog,
          ),
          const Divider(),
          Text(
            widget.content,
            style: AppTheme.textStyles.contentAlertDialog,
          ),
          const SizedBox(height: 10),
          const Text(
            'Se você já tem uma licença. Por favor, ignore essa mensagem.',
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: widget.cancelButton ?? const SizedBox(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: widget.okButton ?? const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
