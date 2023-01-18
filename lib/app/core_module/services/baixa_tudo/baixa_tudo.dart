// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/core_module/services/produtor/bloc/events/produtor_events.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/states/produtor_states.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/events/rotas_events.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/states/rotas_states.dart';

class BaixaTudo {
  final RotasBloc rotasBloc;
  final ProdutorBloc produtorBloc;

  late StreamSubscription subProdutor;
  late StreamSubscription subRotas;

  BaixaTudo({
    required this.rotasBloc,
    required this.produtorBloc,
  }) {
    subProdutor = produtorBloc.stream.listen((state) {
      if (state is SuccessGetProdutor) {
        produtorBloc.add(SaveProdutoresEvent(produtores: state.produtores));
      }
    });

    subRotas = rotasBloc.stream.listen((state) {
      if (state is SuccessGetRotas) {
        rotasBloc.add(SaveRotasEvent(rotas: state.rotas));
      }
    });
  }

  void baixaTudo() {
    produtorBloc.add(GetProdutoresEvent());
    rotasBloc.add(GetRotasEvent());
  }
}
