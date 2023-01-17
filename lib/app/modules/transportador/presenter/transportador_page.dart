import 'dart:async';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/components/my_list_shimmer_widget.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/events/transportador_event.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/states/transportador_states.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransportadorPage extends StatefulWidget {
  final TransportadorBloc transportadorBloc;
  const TransportadorPage({super.key, required this.transportadorBloc});

  @override
  State<TransportadorPage> createState() => _TransportadorPageState();
}

class _TransportadorPageState extends State<TransportadorPage> {
  late StreamSubscription sub;

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

            return ListView.separated(
              itemBuilder: (context, index) {
                final transp = transps[index];

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    color: transp.ultimo ? Colors.green.shade400 : Colors.white,
                  ),
                  child: ListTile(
                    onTap: () {
                      MySnackBar(
                          title: 'O CARAI',
                          message: 'PARA DE CLICAR EM MIM',
                          type: ContentType.failure);
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                            style: AppTheme.textStyles.subTitleCardTranspBold,
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
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: transps.length,
            );
          },
        ),
      ),
    );
  }
}
