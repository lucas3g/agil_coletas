// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/infra/adapters/coletas_adapter.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';
import 'package:agil_coletas/app/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';

class IniciaColetaModalWidget extends StatefulWidget {
  final Rotas rota;
  final Transportador transp;
  final HomeBloc homeBloc;

  const IniciaColetaModalWidget({
    Key? key,
    required this.rota,
    required this.transp,
    required this.homeBloc,
  }) : super(key: key);

  @override
  State<IniciaColetaModalWidget> createState() =>
      _IniciaColetaModalWidgetState();
}

class _IniciaColetaModalWidgetState extends State<IniciaColetaModalWidget> {
  final gkForm = GlobalKey<FormState>();

  late Coletas coleta;

  @override
  void initState() {
    super.initState();

    coleta = ColetasAdapter.empty();

    final fun = GlobalFuncionario.instance.funcionario;

    coleta.setRota(widget.rota.id.value, widget.rota.descricao);
    coleta.setDataMov(DateTime.now().DiaMesAnoDB());
    coleta.setDatasColeta(
      dataHoraInicial:
          '"${DateTime.now().DiaMesAnoDB()} ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}"',
    );
    coleta.setMotorista(fun.name.value);
    coleta.setParticoes(widget.transp.particoes);
    coleta.setPlaca(widget.transp.placa);
    coleta.setCCusto(fun.ccusto.value);

    widget.homeBloc.stream.listen((state) {
      if (state is SuccessCreateColetaHome) {
        coleta.setID(state.coleta.id);

        Modular.to.navigate(
          '/home/tikets/',
          arguments: {
            'coleta': coleta,
            'editando': false,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Iniciar Coleta',
            style: AppTheme.textStyles.titleAlertDialog,
          ),
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rota: ',
                style: AppTheme.textStyles.titleAlertTransp,
              ),
              Expanded(
                child: Text(
                  widget.rota.descricao,
                  style: AppTheme.textStyles.subTitleAlertTransp,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Motorista: ',
                style: AppTheme.textStyles.titleAlertTransp,
              ),
              Expanded(
                child: Text(
                  GlobalFuncionario.instance.funcionario.name.value,
                  style: AppTheme.textStyles.subTitleAlertTransp,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Caminhão: ',
                style: AppTheme.textStyles.titleAlertTransp,
              ),
              Expanded(
                child: Text(
                  widget.transp.descricao,
                  style: AppTheme.textStyles.subTitleAlertTransp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Form(
            key: gkForm,
            child: MyInputWidget(
              label: 'KM Inicial',
              hintText: 'Digite o KM inicial',
              validator: (v) => coleta.km.validateInicial().exceptionOrNull(),
              onChanged: (e) => coleta.km.setInicial(int.tryParse(e) ?? 0),
              keyboardType: TextInputType.number,
              inputFormaters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
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
                    Modular.to.pop('dialog');
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: MyElevatedButtonWidget(
                  height: 45,
                  label: const Text('Iniciar'),
                  onPressed: () {
                    if (!gkForm.currentState!.validate()) {
                      return;
                    }

                    widget.homeBloc.add(CreateColetaEvent(coleta: coleta));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
