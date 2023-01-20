import 'dart:async';

import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/send_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/send_bloc.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/send_states.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SendColetaServerModalWidget extends StatefulWidget {
  final SendBloc sendBloc;

  const SendColetaServerModalWidget({
    Key? key,
    required this.sendBloc,
  }) : super(key: key);

  @override
  State<SendColetaServerModalWidget> createState() =>
      _SendColetaServerModalWidgetState();
}

class _SendColetaServerModalWidgetState
    extends State<SendColetaServerModalWidget> {
  final authBloc = Modular.get<AuthBloc>();

  late StreamSubscription sub;
  late StreamSubscription subAuth;

  @override
  void initState() {
    super.initState();

    subAuth = authBloc.stream.listen((state) {
      if (state is ErrorAuth) {
        if (state.message
            .contains('Você precisa estar conectado em uma de rede WiFi')) {
          Modular.to.pop('dialog');

          MySnackBar(
            title: 'Atenção',
            message: state.message,
            type: ContentType.warning,
          );
        } else {
          authBloc.add(GetDateLicenseEvent());
        }
      }

      if (state is DateLicenseAuth) {
        if (state.dateTime.difference(DateTime.now()).inDays >= 3) {
          MySnackBar(
            title: 'Atenção',
            message: 'Fazem mais de dois que a sua licença não é verificada.',
            type: ContentType.warning,
          );

          Modular.to.pop('dialog');
        } else {
          widget.sendBloc.add(SendColetasToServerEvent());
        }
      }

      if (state is LicenseActiveAuth) {
        authBloc.add(SaveLicenseEvent());
        widget.sendBloc.add(SendColetasToServerEvent());
      }

      if (state is LicenseNotActiveAuth) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não ativa. Por favor, entre em contato com o suporte.',
          type: ContentType.help,
        );

        Modular.to.pop('dialog');
      }

      if (state is LicenseNotFoundAuth) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não encontrada. Por favor, entre em contato com o suporte.',
          type: ContentType.warning,
        );

        Modular.to.pop('dialog');
      }
    });

    sub = widget.sendBloc.stream.listen((state) {
      if (state is SuccessSend) {
        MySnackBar(
          title: 'Sucesso',
          message: 'Todas as coletas foram enviadas',
          type: ContentType.success,
        );

        Modular.to.pop('dialog');
      }

      if (state is AllColetasAlreadyBeenSent) {
        MySnackBar(
          title: 'Informação',
          message: 'Nenhuma coleta para enviar',
          type: ContentType.help,
        );

        Modular.to.pop('dialog');
      }

      if (state is ErrorSend) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.warning,
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
    return ScaffoldMessenger(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
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
                    BlocBuilder<SendBloc, SendStates>(
                        bloc: widget.sendBloc,
                        builder: (context, state) {
                          return BlocBuilder<AuthBloc, AuthStates>(
                              bloc: authBloc,
                              builder: (context, stateAuth) {
                                return Expanded(
                                  child: MyElevatedButtonWidget(
                                    height: 45,
                                    label: state is LoadingSend ||
                                            stateAuth is LoadingAuth
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Enviar'),
                                    onPressed: state is! LoadingSend &&
                                            stateAuth is! LoadingAuth
                                        ? () {
                                            authBloc.add(
                                              VerifyLicenseEvent(
                                                deviceInfo: GlobalDevice
                                                    .instance.deviceInfo,
                                              ),
                                            );
                                          }
                                        : null,
                                  ),
                                );
                              });
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
