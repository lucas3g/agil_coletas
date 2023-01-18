// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/components/my_list_shimmer_widget.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/widgets/tiket_modal_widget.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/formatters.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/modules/tikets/presenter/bloc/events/tiket_events.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/states/tiket_states.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/tiket_bloc.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TiketsPage extends StatefulWidget {
  final TiketBloc tiketBloc;

  const TiketsPage({
    Key? key,
    required this.tiketBloc,
  }) : super(key: key);

  @override
  State<TiketsPage> createState() => _TiketsPageState();
}

class _TiketsPageState extends State<TiketsPage> {
  late StreamSubscription sub;

  final Coletas coleta = Modular.args.data['coleta'];
  final bool editando = Modular.args.data['editando'];

  @override
  void initState() {
    super.initState();

    if (!editando) {
      widget.tiketBloc.add(CreateTiketsEvent(coleta: coleta));
    } else {
      widget.tiketBloc.add(GetTiketsEvent(codColeta: coleta.id));
    }

    sub = widget.tiketBloc.stream.listen((state) {
      if (state is ErrorTiket) {
        MySnackBar(
          title: 'Ops...',
          message: state.message,
          type: ContentType.failure,
        );
      }

      if (state is SuccessCreateTiket || state is SuccessUpdateTikets) {
        widget.tiketBloc.add(GetTiketsEvent(codColeta: coleta.id));
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();

    super.dispose();
  }

  Color retornaCorDoCard(Tiket tiket) {
    if (tiket.alizarol) {
      return Colors.orange;
    }

    if (tiket.quantidade.value > 0 && tiket.temperatura.value != 0.0) {
      return Colors.green.shade400;
    }

    if (tiket.quantidade.value == 0 &&
        tiket.temperatura.value == 0.0 &&
        tiket.observacao.isEmpty) {
      return Colors.grey.shade400;
    }

    if (tiket.observacao.isNotEmpty) {
      return Colors.red.shade400;
    }

    return Colors.amber.shade300;
  }

  Icon retornaIconeCard(Tiket tiket) {
    if (tiket.alizarol) {
      return const Icon(
        Icons.warning_amber_rounded,
        size: 30,
        color: Colors.black,
      );
    }

    if (tiket.quantidade.value > 0 && tiket.temperatura.value != 0.0) {
      return const Icon(
        Icons.check_circle_outline,
        size: 30,
        color: Colors.black,
      );
    }

    if (tiket.quantidade.value == 0 &&
        tiket.temperatura.value == 0.0 &&
        tiket.observacao.isEmpty) {
      return const Icon(
        Icons.person_outline,
        size: 30,
        color: Colors.black,
      );
    }

    if (tiket.observacao.isNotEmpty) {
      return const Icon(
        Icons.error_outline_rounded,
        size: 30,
        color: Colors.black,
      );
    }

    return const Icon(
      Icons.warning_amber_rounded,
      size: 30,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: MyAppBarWidget(
          titleAppbar: 'Tikets',
          backButton: BackButton(
            color: Colors.white,
            onPressed: () {
              Modular.to.navigate('/home/');
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            MyInputWidget(
              label: 'Pesquisa',
              hintText: 'Digite o nome do produtor',
              onChanged: (e) {
                widget.tiketBloc.add(FilterTiketsEvent(filtro: e));
              },
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const Divider(),
            BlocBuilder(
              bloc: widget.tiketBloc,
              builder: (context, state) {
                if (state is! SuccessGetTikets) {
                  return const MyListShimmerWidget();
                }

                final tikets = state.tiketsFiltrados;

                if (tikets.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('Nenhum tiket encontrado'),
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final tiket = tikets[index];

                            return Container(
                              decoration: BoxDecoration(
                                  color: retornaCorDoCard(tiket),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: retornaCorDoCard(tiket),
                                      blurRadius: 3,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: ListTile(
                                onTap: () async {
                                  await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => TiketModalWidget(
                                      tiket: tiket,
                                      tiketBloc: widget.tiketBloc,
                                    ),
                                  );

                                  setState(() {});
                                },
                                leading: SizedBox(
                                  height: double.maxFinite,
                                  child: retornaIconeCard(tiket),
                                ),
                                title: Text(
                                  tiket.produtor.nome,
                                  style: AppTheme.textStyles.titleListTikets,
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Município: ',
                                      style: AppTheme
                                          .textStyles.subTitleListTikets,
                                    ),
                                    Expanded(
                                      child: Text(tiket.produtor.municipio),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: tikets.length,
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: MyElevatedButtonWidget(
                              height: 50,
                              label: Text(
                                'Finalizar Rota',
                                style: AppTheme.textStyles.labelButtonFinalizar,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
