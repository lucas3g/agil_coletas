// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/components/my_list_shimmer_widget.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/events/rotas_events.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/states/rotas_states.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/formatters.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RotasPage extends StatefulWidget {
  final RotasBloc rotasBloc;

  const RotasPage({
    Key? key,
    required this.rotasBloc,
  }) : super(key: key);

  @override
  State<RotasPage> createState() => _RotasPageState();
}

class _RotasPageState extends State<RotasPage> {
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.rotasBloc.add(GetRotasEvent());

    sub = widget.rotasBloc.stream.listen((state) {
      if (state is ErrorRotas) {
        MySnackBar(
          title: 'Ops...',
          message: state.message,
          type: ContentType.failure,
        );
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
          titleAppbar: 'Rotas',
          backButton: BackButton(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            MyInputWidget(
              label: 'Pesquisa',
              hintText: 'Digite o nome ou código da rota',
              onChanged: (String? value) {
                widget.rotasBloc.add(FiltraRotasEvent(value: value!));
              },
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const Divider(),
            BlocBuilder<RotasBloc, RotasStates>(
                bloc: widget.rotasBloc,
                builder: (context, state) {
                  if (state is! SuccessGetRotas) {
                    return const MyListShimmerWidget();
                  }

                  final rotas = state.rotasFiltradas;

                  if (rotas.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Lista de rotas está vazia',
                          style: AppTheme.textStyles.labelNotFound,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final rota = rotas[index];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                  color: rota.finalizada
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                ),
                                child: ListTile(
                                  onTap: () {
                                    if (!rota.finalizada) {
                                      MySnackBar(
                                        title: 'Atenção',
                                        message: 'Rota pendente de finalização',
                                        type: ContentType.warning,
                                      );

                                      return;
                                    }

                                    Modular.to.pushNamed(
                                        '/home/rotas/transportador/',
                                        arguments: {'ROTA': rota});
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.room_outlined,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                            '${rota.id.value} - ${rota.descricao}'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: rotas.length,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
