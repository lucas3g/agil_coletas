// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/components/my_list_shimmer_widget.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/utils/constants.dart';
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

  final int codRota = Modular.args.data['codRota'];
  final Coletas coleta = Modular.args.data['coleta'];

  @override
  void initState() {
    super.initState();

    widget.tiketBloc.add(GetProdutoresEvent(codRota: codRota));

    widget.tiketBloc.add(GetTiketsEvent(codColeta: coleta.id));

    sub = widget.tiketBloc.stream.listen((state) {
      if (state is SuccessGetProdutoresTiket) {
        widget.tiketBloc.add(SaveProdutoresEvent(produtores: state.produtores));
        widget.tiketBloc.add(
          CreateTiketsEvent(
            produtores: state.produtores,
            coleta: coleta,
          ),
        );
      }

      if (state is ErrorTiket) {
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
          titleAppbar: 'Tikets',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: BlocBuilder(
          bloc: widget.tiketBloc,
          builder: (context, state) {
            if (state is! SuccessGetTikets) {
              return const MyListShimmerWidget();
            }

            final tikets = state.tikets;

            return ListView.separated(
              itemBuilder: (context, index) {
                final tiket = tikets[index];

                return Text(tiket.idColeta.toString());
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: tikets.length,
            );
          },
        ),
      ),
    );
  }
}
