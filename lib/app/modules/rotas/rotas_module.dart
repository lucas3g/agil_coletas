import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/get_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/external/datasource/rotas_datasource.dart';
import 'package:agil_coletas/app/modules/rotas/infra/datasources/rotas_datasource.dart';
import 'package:agil_coletas/app/modules/rotas/infra/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/rotas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class RotasModules extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IRotasDatasource>(
      (i) => RotasDatasource(clientHttp: i(), storage: i()),
    ),

    //REPOSITORIES
    Bind.factory<IRotasRepository>((i) => RotasRepository(datasource: i())),

    //USECASES
    Bind.factory<IGetRotasUseCase>((i) => GetRotasUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<RotasBloc>((i) => RotasBloc(getRotasUseCase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => RotasPage(
        rotasBloc: Modular.get<RotasBloc>(),
      ),
    )
  ];
}
