// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/components/my_list_shimmer_widget.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/events/transportador_event.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/states/transportador_states.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/widgets/inicia_coleta_modal_widget.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/formatters.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';

class TransportadorPage extends StatefulWidget {
  final TransportadorBloc transportadorBloc;
  final HomeBloc homeBloc;

  const TransportadorPage({
    Key? key,
    required this.transportadorBloc,
    required this.homeBloc,
  }) : super(key: key);

  @override
  State<TransportadorPage> createState() => _TransportadorPageState();
}

class _TransportadorPageState extends State<TransportadorPage> {
  late StreamSubscription sub;
  late StreamSubscription subColeta;

  final Rotas rota = Modular.args.data['ROTA'];

  @override
  void initState() {
    super.initState();

    widget.transportadorBloc.add(GetTransportadorEvent());

    sub = widget.transportadorBloc.stream.listen((state) {
      if (state is ErrorTransportador) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });

    subColeta = widget.homeBloc.stream.listen((state) {
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
    subColeta.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(
          titleAppbar: 'Transportador',
          backButton: BackButton(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: BlocBuilder<TransportadorBloc, TransportadorStates>(
          bloc: widget.transportadorBloc,
          builder: (context, state) {
            if (state is! SuccessGetTransportador) {
              return const MyListShimmerWidget();
            }

            final transps = state.transpFiltrados;

            if (transps.isEmpty) {
              return const Center(
                child: Text('Lista de transportadores está vazia.'),
              );
            }

            return Column(
              children: [
                MyInputWidget(
                  label: 'Pesquisa',
                  hintText: 'Digite o nome ou placa do transportador',
                  onChanged: (String? value) {
                    widget.transportadorBloc
                        .add(FiltraTransportadorEvent(value: value!));
                  },
                  inputFormaters: [UpperCaseTextFormatter()],
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final transp = transps[index];

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          color: transp.ultimo
                              ? Colors.green.shade400
                              : Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => IniciaColetaModalWidget(
                                rota: rota,
                                transp: transp,
                                homeBloc: widget.homeBloc,
                              ),
                            );
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          minLeadingWidth: 10,
                          leading: const SizedBox(
                            height: double.maxFinite,
                            child: Icon(
                              Icons.local_shipping_outlined,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            transp.descricao,
                            style: AppTheme.textStyles.titleCardTransp,
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Placa: ',
                                  style: AppTheme
                                      .textStyles.subTitleCardTranspBold,
                                ),
                                TextSpan(
                                  text: transp.placa,
                                  style: AppTheme.textStyles.subTitleCardTransp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: transps.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
