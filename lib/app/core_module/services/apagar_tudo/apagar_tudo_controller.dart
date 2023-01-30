import 'package:agil_coletas/app/core_module/services/produtor/bloc/events/produtor_events.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/events/rotas_events.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/events/tiket_events.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/tiket_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/events/transportador_event.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ApagarTudoController {
  static Future apagarTudo() async {
    final produtorBloc = Modular.get<ProdutorBloc>();
    final rotasBloc = Modular.get<RotasBloc>();
    final transpBloc = Modular.get<TransportadorBloc>();
    final coletasBloc = Modular.get<HomeBloc>();
    final tiketBloc = Modular.get<TiketBloc>();

    produtorBloc.add(RemoveAllProdutores());
    rotasBloc.add(RemoveAllRotasEvent());
    transpBloc.add(RemoveAllTransportadores());
    coletasBloc.add(RemoveAllColetasEvent());
    tiketBloc.add(RemoveAllTiketsEvent());

    produtorBloc.close();
    rotasBloc.close();
    transpBloc.close();
    coletasBloc.close();
    tiketBloc.close();

    await SystemNavigator.pop();
  }
}
