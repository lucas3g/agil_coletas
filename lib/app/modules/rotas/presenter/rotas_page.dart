// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/events/rotas_events.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/states/rotas_states.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();

    widget.rotasBloc.add(GetRotasEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Rotas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: BlocBuilder<RotasBloc, RotasStates>(
            bloc: widget.rotasBloc,
            builder: (context, state) {
              if (state is! SuccessGetRotas) {
                return const Center(
                  child: LoadingWidget(
                    size: Size(double.infinity, 45),
                    radius: 10,
                  ),
                );
              }

              final rotas = state.rotasFilteradas;

              if (rotas.isEmpty) {
                return const Center(
                  child: Text('Lista de rotas está vazia'),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  final rota = rotas[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(rota.descricao),
                      subtitle: Text(rota.transportador),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: rotas.length,
              );
            }),
      ),
    );
  }
}
