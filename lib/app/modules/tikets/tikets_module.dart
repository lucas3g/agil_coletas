import 'package:agil_coletas/app/modules/rotas/rotas_module.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/tikets_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TiketsModule extends Module {
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
      child: (context, args) => const TiketsPage(),
    ),
  ];
}
