// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/core_module/services/produtor/bloc/events/produtor_events.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/states/produtor_states.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/events/rotas_events.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/states/rotas_states.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/events/transportador_event.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/states/transportador_states.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';

class BaixaTudo {
  final RotasBloc rotasBloc;
  final ProdutorBloc produtorBloc;
  final TransportadorBloc transportadorBloc;

  late StreamSubscription subProdutor;
  late StreamSubscription subRotas;
  late StreamSubscription subTransp;

  BaixaTudo({
    required this.rotasBloc,
    required this.produtorBloc,
    required this.transportadorBloc,
  }) {
    subProdutor = produtorBloc.stream.listen((state) {
      if (state is SuccessGetProdutor) {
        produtorBloc.add(SaveProdutoresEvent(produtores: state.produtores));
        subProdutor.cancel();
      }
    });

    subRotas = rotasBloc.stream.listen((state) {
      if (state is SuccessGetRotas) {
        rotasBloc.add(SaveRotasEvent(rotas: state.rotas));
        subRotas.cancel();
      }
    });

    subTransp = transportadorBloc.stream.listen((state) {
      if (state is SuccessGetTransportador) {
        transportadorBloc.add(
            SaveTransportadorEvent(transportadores: state.transportadores));
        subTransp.cancel();
      }
    });
  }

  void baixaTudo() {
    produtorBloc.add(GetProdutoresEvent());
    rotasBloc.add(GetRotasEvent());
    transportadorBloc.add(GetTransportadorEvent());
  }
}
