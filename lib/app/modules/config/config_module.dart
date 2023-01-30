import 'package:agil_coletas/app/modules/config/presenter/config_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const ConfigPage(),
    ),
  ];
}
