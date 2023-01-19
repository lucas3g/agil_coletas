import 'dart:async';

import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SendColetaServerModalWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  const SendColetaServerModalWidget({
    Key? key,
    required this.homeBloc,
  }) : super(key: key);

  @override
  State<SendColetaServerModalWidget> createState() =>
      _SendColetaServerModalWidgetState();
}

class _SendColetaServerModalWidgetState
    extends State<SendColetaServerModalWidget> {
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    sub = widget.homeBloc.stream.listen((state) {
      if (state is SuccessSendColetaToServerHome) {
        MySnackBar(
          title: 'Sucesso',
          message: 'Todas as coletas foram enviadas',
          type: ContentType.success,
        );

        Modular.to.pop('dialog');
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enviar coletas para o servidor?',
            style: AppTheme.textStyles.titleAlertDialog,
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: MyElevatedButtonWidget(
                  backgroundColor: Colors.black,
                  textButtonColor: Colors.white,
                  height: 45,
                  label: const Text('Cancelar'),
                  onPressed: () {
                    Modular.to.pop('dialog');
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: MyElevatedButtonWidget(
                  height: 45,
                  label: const Text('Enviar'),
                  onPressed: () {
                    widget.homeBloc.add(SendColetasToServerEvent());
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
