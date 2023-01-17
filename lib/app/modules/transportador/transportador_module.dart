import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/get_transportador_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/external/datasources/transportador_datasource.dart';
import 'package:agil_coletas/app/modules/transportador/infra/datasources/transportador_datasouce.dart';
import 'package:agil_coletas/app/modules/transportador/infra/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/transportador_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class TransportadorModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<ITransportadorDatasource>(
      (i) => TransportadorDatasource(clientHttp: i(), storage: i()),
    ),

    //REPOSITORIES
    Bind.factory<ITransportadorRepository>(
        (i) => TransportadorRepository(datasource: i())),

    //USECASES
    Bind.factory<IGetTransportadorUseCase>(
        (i) => GetTransportadorUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<TransportadorBloc>(
        (i) => TransportadorBloc(getTransportadorUseCase: i())),
  ];

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
