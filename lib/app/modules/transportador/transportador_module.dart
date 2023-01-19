import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/transportador_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TransportadorModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => TransportadorPage(
        transportadorBloc: Modular.get<TransportadorBloc>(),
        homeBloc: Modular.get<HomeBloc>(),
      ),
    ),
  ];
}
