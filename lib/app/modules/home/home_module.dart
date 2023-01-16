import 'package:agil_coletas/app/modules/home/presenter/home_page.dart';
import 'package:agil_coletas/app/modules/rotas/rotas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Module> imports = [
    RotasModules(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const HomePage(),
    ),
    ModuleRoute(
      '/rotas',
      module: RotasModules(),
      transition: TransitionType.noTransition,
    ),
  ];
}
