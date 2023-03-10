import 'dart:async';

import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/states/license_states.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
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
  final licenseBloc = Modular.get<LicenseBloc>();

  late StreamSubscription sub;
  late StreamSubscription subLicense;

  @override
  void initState() {
    super.initState();

    subLicense = licenseBloc.stream.listen((state) {
      if (state is ErrorLicense) {
        if (state.message
            .contains('Você precisa estar conectado em uma de rede WiFi')) {
          Modular.to.pop('dialog');

          MySnackBar(
            title: 'Atenção',
            message: state.message,
            type: ContentType.warning,
          );
        } else {
          licenseBloc.add(GetDateLicenseEvent());
        }
      }

      if (state is DateLicense) {
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

      if (state is LicenseActive) {
        licenseBloc.add(SaveLicenseEvent());
        widget.sendBloc.add(SendColetasToServerEvent());
      }

      if (state is LicenseNotActive) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não ativa. Por favor, entre em contato com o suporte.',
          type: ContentType.help,
        );

        Modular.to.pop('dialog');
      }

      if (state is LicenseNotFound) {
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enviar coletas para o servidor?',
              style: AppTheme.textStyles.titleAlertDialog,
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: MyElevatedButtonWidget(
                    backgroundColor: Colors.black,
                    textButtonColor: Colors.white,
                    height: 45,
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel),
                        SizedBox(width: 5),
                        Text('Cancelar'),
                      ],
                    ),
                    onPressed: () {
                      Modular.to.pop('dialog');
                    },
                  ),
                ),
                const SizedBox(width: 15),
                BlocBuilder<SendBloc, SendStates>(
                    bloc: widget.sendBloc,
                    builder: (context, state) {
                      return BlocBuilder<LicenseBloc, LicenseStates>(
                          bloc: licenseBloc,
                          builder: (context, stateLicense) {
                            return Expanded(
                              child: MyElevatedButtonWidget(
                                height: 45,
                                label: state is LoadingSend ||
                                        stateLicense is LoadingLicense
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.send),
                                          SizedBox(width: 5),
                                          Text('Enviar'),
                                        ],
                                      ),
                                onPressed: state is! LoadingSend &&
                                        stateLicense is! LoadingLicense
                                    ? () {
                                        licenseBloc.add(
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
  }
}
