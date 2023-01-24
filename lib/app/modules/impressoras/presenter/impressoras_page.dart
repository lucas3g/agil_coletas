// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/events/impressora_events.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/states/impressora_state.dart';
import 'package:agil_coletas/app/modules/impressoras/presenter/widgets/card_list_impressoras_widget.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImpressorasPage extends StatefulWidget {
  final ImpressoraBloc impressoraBloc;

  const ImpressorasPage({
    Key? key,
    required this.impressoraBloc,
  }) : super(key: key);

  @override
  State<ImpressorasPage> createState() => _ImpressorasPageState();
}

class _ImpressorasPageState extends State<ImpressorasPage> {
  late int selectedIndex = -1;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.impressoraBloc.add(GetImpressorasEvent());

    sub = widget.impressoraBloc.stream.listen((state) {
      if (state is ErrorImpressora) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }

      if (state is SuccessGetImpressora) {
        widget.impressoraBloc.add(GetImpressoraConectadaLocalStorageEvent());

        setState(() {});
      }

      if (state is SuccessConnectImpressora) {
        widget.impressoraBloc.add(
          SaveImpressoraLocalStorageEvent(imp: state.imp),
        );
      }

      if (state is SuccessDisconnectImpressora) {
        widget.impressoraBloc.add(RemoveImpressoraLocalStorageEvent());
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
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(
          titleAppbar: 'Impressoras',
          backButton: BackButton(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Text(
              'Lista de Impressoras',
              style: AppTheme.textStyles.titleListaColetas,
            ),
            const Divider(),
            BlocBuilder<ImpressoraBloc, ImpressoraStates>(
                bloc: widget.impressoraBloc,
                builder: (context, state) {
                  if (state is LoadingImpressora) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SuccessGetImpressora ||
                      state is LoadingConnectImpressora ||
                      state is SuccessConnectImpressora ||
                      state is SuccessDisconnectImpressora) {
                    final impressoras = state.impressoras;

                    if (impressoras.isEmpty) {
                      return const Center(
                        child: Text(
                            'Nenhuma impressora encontrada ou Bluetooth esta desligado.'),
                      );
                    }

                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final imp = impressoras[index];

                          return CardListImpressorasWidget(
                            impressoraBloc: widget.impressoraBloc,
                            imp: imp,
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: impressoras.length,
                      ),
                    );
                  }

                  return const SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
