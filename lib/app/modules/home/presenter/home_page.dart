// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/components/my_list_shimmer_widget.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';

class HomePage extends StatefulWidget {
  final HomeBloc homeBloc;
  const HomePage({
    Key? key,
    required this.homeBloc,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final funcionario = GlobalFuncionario.instance.funcionario;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.homeBloc.add(GetColetasEvent());

    sub = widget.homeBloc.stream.listen((state) {
      if (state is ErrorHome) {
        MySnackBar(
          title: 'Opss...',
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

  Widget contentListTile(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: AppTheme.textStyles.titleCardListaColetas,
        ),
        Text(
          value,
          style: AppTheme.textStyles.subTitleCardListaColetas,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: Text(
          '..: ${funcionario.empresa.nome} :..',
          style: AppTheme.textStyles.titleAppBar,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.white,
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: context.screenHeight * .15,
                color: Colors.white,
                child: Theme(
                  data: ThemeData().copyWith(
                    dividerColor: Colors.white,
                  ),
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppTheme.colors.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Motorista: ${funcionario.name.value}',
                          style: AppTheme.textStyles.titleDrawer,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: context.screenHeight * .85,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Configuração',
                            style: AppTheme.textStyles.subtitleDrawer,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(
                            'Impressora',
                            style: AppTheme.textStyles.subtitleDrawer,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(
                            'Sair',
                            style: AppTheme.textStyles.subtitleDrawer,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        'Versão 1.0.0',
                        textAlign: TextAlign.end,
                        style: AppTheme.textStyles.subtitleDrawer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: BlocBuilder<HomeBloc, HomeStates>(
            bloc: widget.homeBloc,
            builder: (context, state) {
              if (state is! SuccessGetColetasHome) {
                return const MyListShimmerWidget();
              }

              final coletas = state.coletas;

              if (coletas.isEmpty) {
                return const Center(
                  child: Text('Lista de coletas esta vazia.'),
                );
              }

              return Column(
                children: [
                  Text(
                    'Lista de Coletas',
                    style: AppTheme.textStyles.titleListaColetas,
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final coleta = coletas[index];

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey.shade300,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border: coleta.finalizada
                                    ? AppTheme.borderStyle.borderGreen
                                    : AppTheme.borderStyle.borderRed,
                              ),
                              child: ListTile(
                                onTap: () {
                                  switch (coleta.finalizada) {
                                    case true:
                                      MySnackBar(
                                        title: 'Atenção',
                                        message: 'Coleta já finalizada',
                                        type: ContentType.help,
                                      );

                                      break;
                                    default:
                                      Modular.to.pushNamed('/home/tikets/');
                                  }
                                },
                                trailing: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: !coleta.enviada
                                        ? AppTheme.colors.primary
                                        : AppTheme.colors.verde,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${coleta.rota.rota} - ${coleta.rota.nome}',
                                        ),
                                      ],
                                    ),
                                    contentListTile(
                                      'Data Mov.: ',
                                      coleta.dataMov.replaceAll('.', '/'),
                                    ),
                                    contentListTile(
                                      'KM: ',
                                      '${coleta.km.inical} / ${coleta.km.ffinal}',
                                    ),
                                    contentListTile(
                                      'Placa: ',
                                      coleta.placa,
                                    ),
                                    contentListTile(
                                      'Total Coletado: ',
                                      '${coleta.totalColetado}',
                                    ),
                                    contentListTile(
                                      'Rota Finalizada: ',
                                      coleta.finalizada ? 'Sim' : 'Não',
                                    ),
                                    contentListTile(
                                      'Rota Enviada: ',
                                      coleta.enviada ? 'Sim' : 'Não',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: coletas.length,
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'botao1',
              onPressed: () {},
              child: const Icon(Icons.cloud_upload_rounded),
            ),
            FloatingActionButton(
              heroTag: 'botao2',
              onPressed: () {
                Modular.to.pushNamed('/home/rotas/');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
