import 'package:agil_coletas/app/modules/home/domain/repositories/home_repository.dart';
import 'package:agil_coletas/app/modules/home/domain/usecases/create_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/home/domain/usecases/get_coletas_usecase.dart';
import 'package:agil_coletas/app/modules/home/domain/usecases/update_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/home/external/datasources/home_datasource.dart';
import 'package:agil_coletas/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:agil_coletas/app/modules/home/infra/repositories/home_repository.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/home/presenter/home_page.dart';
import 'package:agil_coletas/app/modules/rotas/rotas_module.dart';
import 'package:agil_coletas/app/modules/tikets/tikets_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class HomeModule extends Module {
  @override
  final List<Module> imports = [
    RotasModules(),
    TiketsModule(),
  ];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IHomeDatasource>(
      (i) => HomeDatasource(storage: i(), clientHttp: i()),
    ),

    //REPOSITORIES
    Bind.factory<IHomeRepository>(
      (i) => HomeRepository(datasource: i()),
    ),

    //USECASES
    Bind.factory<IGetColetasUseCase>(
      (i) => GetColetasUseCase(repository: i()),
    ),
    Bind.factory<ICreateColetasUseCase>(
      (i) => CreateColetasUseCase(repository: i()),
    ),
    Bind.factory<IUpdateColetasUseCase>(
      (i) => UpdateColetasUseCase(repository: i()),
    ),

    //BLOCS
    BlocBind.factory<HomeBloc>(
      (i) => HomeBloc(
        getColetasUseCase: i(),
        createColetasUseCase: i(),
        updateColetasUseCase: i(),
        sendColetaToServerUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => HomePage(
        homeBloc: Modular.get<HomeBloc>(),
      ),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      '/rotas',
      module: RotasModules(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      '/tikets',
      module: TiketsModule(),
      transition: TransitionType.noTransition,
    ),
  ];
}
