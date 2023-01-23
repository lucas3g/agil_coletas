// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/events/impressora_events.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/states/impressora_state.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';

class CardListImpressorasWidget extends StatefulWidget {
  final ImpressoraBloc impressoraBloc;
  final Impressoras imp;
  final int index;

  const CardListImpressorasWidget({
    Key? key,
    required this.impressoraBloc,
    required this.imp,
    required this.index,
  }) : super(key: key);

  @override
  State<CardListImpressorasWidget> createState() =>
      _CardListImpressorasWidgetState();
}

class _CardListImpressorasWidgetState extends State<CardListImpressorasWidget> {
  late int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<ImpressoraBloc, ImpressoraStates>(
          bloc: widget.impressoraBloc,
          builder: (context, stateImp) {
            return ListTile(
              onTap: () {
                setState(() {
                  selectedIndex = widget.index;
                });

                if (widget.imp.connected) {
                  widget.impressoraBloc.add(
                    DisconnectImpressoraEvent(imp: widget.imp),
                  );

                  return;
                }

                widget.impressoraBloc.add(
                  ConnectImpressoraEvent(imp: widget.imp),
                );
              },
              title: Text(widget.imp.name),
              subtitle: widget.imp.connected
                  ? Text(
                      'Impressora Conectada!',
                      style: AppTheme.textStyles.subtitleCardImpressora,
                    )
                  : const Text('Pressione para Conectar!'),
              trailing: stateImp is LoadingConnectImpressora &&
                      selectedIndex == widget.index
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    )
                  : widget.imp.connected
                      ? IconButton(
                          onPressed: () {
                            widget.impressoraBloc.add(
                              ImprimirPaginaTesteEvent(),
                            );
                          },
                          icon: Icon(
                            Icons.print_rounded,
                            color: AppTheme.colors.primary,
                          ),
                        )
                      : const SizedBox(),
            );
          }),
    );
  }
}
