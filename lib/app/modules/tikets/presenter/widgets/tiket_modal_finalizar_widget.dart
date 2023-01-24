// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/events/impressora_events.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';

class TiketModalFinalizarWidget extends StatefulWidget {
  final Coletas coleta;
  final ImpressoraBloc impressoraBloc;
  final Impressoras imp;

  const TiketModalFinalizarWidget({
    Key? key,
    required this.coleta,
    required this.impressoraBloc,
    required this.imp,
  }) : super(key: key);

  @override
  State<TiketModalFinalizarWidget> createState() =>
      _TiketModalFinalizarWidgetState();
}

class _TiketModalFinalizarWidgetState extends State<TiketModalFinalizarWidget> {
  final homeBloc = Modular.get<HomeBloc>();
  final gkForm = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    sub = homeBloc.stream.listen((state) {
      if (state is SuccessUpdateColetaHome) {
        if (widget.imp.connected) {
          widget.impressoraBloc.add(ImprimirRotaFinalizadaEvent(widget.coleta));
        }

        MySnackBar(
          title: 'Sucesso',
          message: 'Rota finalizada.',
          type: ContentType.success,
        );

        Modular.to.navigate('/home/');
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
      content: Form(
        key: gkForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Finalizar Rota',
              style: AppTheme.textStyles.titleAlertDialog,
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            MyInputWidget(
              autofocus: true,
              label: 'KM Final',
              hintText: 'Digite o KM final',
              value: widget.coleta.km.ffinal > 0
                  ? widget.coleta.km.ffinal.toString()
                  : '',
              validator: (v) =>
                  widget.coleta.km.validateFinal().exceptionOrNull(),
              onChanged: (e) =>
                  widget.coleta.setKM(kmFim: int.tryParse(e) ?? 0),
              keyboardType: TextInputType.number,
              inputFormaters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: MyElevatedButtonWidget(
                    height: 45,
                    label: const Text('Finalizar'),
                    onPressed: () {
                      if (!gkForm.currentState!.validate()) {
                        return;
                      }

                      widget.coleta.setFinalizada(true);

                      homeBloc.add(UpdateColetaEvent(coleta: widget.coleta));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
