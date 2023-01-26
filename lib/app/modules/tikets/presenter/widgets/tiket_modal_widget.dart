// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:agil_coletas/app/components/my_drop_down_button_widget.dart';
import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/events/impressora_events.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket_clone.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/tiket_adapter.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/events/tiket_events.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/states/tiket_states.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/tiket_bloc.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';

class TiketModalWidget extends StatefulWidget {
  final Tiket tiket;
  final TiketBloc tiketBloc;
  final ImpressoraBloc impressoraBloc;
  final Impressoras imp;
  final int particoes;

  const TiketModalWidget({
    Key? key,
    required this.tiket,
    required this.tiketBloc,
    required this.impressoraBloc,
    required this.imp,
    required this.particoes,
  }) : super(key: key);

  @override
  State<TiketModalWidget> createState() => _TiketModalWidgetState();
}

class _TiketModalWidgetState extends State<TiketModalWidget> {
  final qtdController = TextEditingController();
  final tempController = TextEditingController();

  final fQtd = FocusNode();
  final fTemp = FocusNode();

  late Tiket tiket;
  late TiketClone tiketClone;

  late List<String> tanques = [];

  final gkForm = GlobalKey<FormState>();

  late StreamSubscription sub;

  void geraListaTanques() {
    for (var i = 1; i <= widget.particoes; i++) {
      tanques.add(i.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    tiket = widget.tiket;
    tiketClone = TiketAdapter.toTiketClone(tiket);

    geraListaTanques();

    qtdController.text = tiket.quantidade.value.toString();
    tempController.text = tiket.temperatura.value.toString();

    sub = widget.tiketBloc.stream.listen((state) {
      if (state is ErrorTiket) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });

    fQtd.addListener(() {
      if (fQtd.hasFocus) {
        qtdController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: qtdController.text.length,
        );
      }
    });

    fTemp.addListener(() {
      if (fTemp.hasFocus) {
        tempController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: tempController.text.length,
        );
      }
    });
  }

  @override
  void dispose() {
    fQtd.removeListener(() {});
    fTemp.removeListener(() {});
    sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: gkForm,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Lançar Tiket',
                  style: AppTheme.textStyles.titleAlertDialog,
                ),
              ),
              const Divider(),
              const Text('Quantidade LT'),
              const SizedBox(height: 10),
              MyInputWidget(
                autofocus: true,
                maxLength: 5,
                controller: qtdController,
                focusNode: fQtd,
                label: 'Quantidade',
                value: tiket.quantidade.value.toString(),
                onSaved: (e) => tiket.setQuantidade(int.tryParse(e!) ?? 0),
                validator: (v) {
                  if (double.tryParse(v!) == null) {
                    return 'Quantidade invalida';
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onFieldSubmitted: (_) => fTemp.requestFocus(),
              ),
              const SizedBox(height: 10),
              const Text('Temperatura'),
              const SizedBox(height: 10),
              MyInputWidget(
                maxLength: 5,
                controller: tempController,
                focusNode: fTemp,
                label: 'Temperatura',
                value: tiket.temperatura.value.toString(),
                validator: (v) {
                  if (double.tryParse(v!) == null) {
                    return 'Temperatura invalida';
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (e) =>
                    tiket.setTemperatura(double.tryParse(e!) ?? 0.0),
                onChanged: (v) {
                  tempController.text = v.replaceAll(',', '.');
                  tempController.selection = TextSelection.fromPosition(
                      TextPosition(offset: tempController.text.length));
                },
              ),
              const SizedBox(height: 10),
              const Text('Alizarol'),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  tiket.setAlizarol(!tiket.alizarol);
                  setState(() {});
                },
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.colors.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: tiket.alizarol,
                        onChanged: (value) {
                          tiket.setAlizarol(value!);
                          setState(() {});
                        },
                        activeColor: AppTheme.colors.primary,
                      ),
                      Text(tiket.alizarol ? 'Positivo' : 'Negativo')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Tanque'),
              const SizedBox(height: 10),
              MyDropDownButtonWidget(
                onChanged: (e) => tiket.setParticao(int.parse(e!)),
                value: tiket.particao.toString(),
                hint: 'Tanque',
                items: tanques
                    .map(
                      (String value) => DropdownMenuItem(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              const Text('Observação'),
              const SizedBox(height: 10),
              MyInputWidget(
                label: 'Observação',
                value: tiket.observacao,
                onSaved: (e) => tiket.setObservacao(e!),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MyElevatedButtonWidget(
                      backgroundColor: Colors.black,
                      textButtonColor: Colors.white,
                      height: 45,
                      label: const Text('Cancelar'),
                      onPressed: () {
                        if (tiket.alizarol != tiketClone.alizarol) {
                          tiket.setAlizarol(tiketClone.alizarol);
                        }
                        if (tiket.particao != tiketClone.particao) {
                          tiket.setParticao(tiketClone.particao);
                        }

                        Modular.to.pop('dialog');
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: MyElevatedButtonWidget(
                      height: 45,
                      label: const Text('Salvar'),
                      onPressed: () {
                        if (!gkForm.currentState!.validate()) {
                          return;
                        } else {
                          gkForm.currentState!.save();
                        }

                        tiket.setHora(
                          '"${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}"',
                        );

                        widget.tiketBloc.add(UpdateTiketEvent(tiket: tiket));

                        if (widget.imp.connected) {
                          widget.impressoraBloc.add(ImprimirTiketEvent(tiket));
                        }

                        Modular.to.pop('dialog');
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
