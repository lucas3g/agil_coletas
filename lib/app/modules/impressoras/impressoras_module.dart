import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:agil_coletas/app/modules/impressoras/presenter/impressoras_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ImpressorasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => ImpressorasPage(
        impressoraBloc: Modular.get<ImpressoraBloc>(),
      ),
    )
  ];
}
