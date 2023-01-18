import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/rotas_page.dart';
import 'package:agil_coletas/app/modules/transportador/transportador_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RotasModules extends Module {
  @override
  final List<Module> imports = [
    TransportadorModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => RotasPage(
        rotasBloc: Modular.get<RotasBloc>(),
      ),
    ),
    ModuleRoute(
      '/transportador',
      module: TransportadorModule(),
    )
  ];
}
