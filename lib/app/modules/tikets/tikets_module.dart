import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/rotas_module.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/create_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/get_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/remove_all_tikets_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/update_tiket_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/external/tiket_datasource.dart';
import 'package:agil_coletas/app/modules/tikets/infra/datasources/tiket_datasource.dart';
import 'package:agil_coletas/app/modules/tikets/infra/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/tiket_bloc.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/tikets_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class TiketsModule extends Module {
  @override
  final List<Module> imports = [
    RotasModules(),
  ];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<ITiketDatasource>(
      (i) => TiketDatasource(clientHttp: i(), storage: i()),
    ),

    //REPOSITORIES
    Bind.factory<ITiketRepository>(
      (i) => TiketRepository(datasource: i()),
    ),

    //USECASES
    Bind.factory<IGetTiketByColetaUseCase>(
      (i) => GetTiketByColetaUseCase(repository: i()),
    ),
    Bind.factory<ICreateTiketByColetaUseCase>(
      (i) => CreateTiketByColetaUseCase(repository: i()),
    ),
    Bind.factory<IUpdateTiketUseCase>(
      (i) => UpdateTiketUseCase(repository: i()),
    ),
    Bind.factory<IRemoveAllTiketUseCase>(
      (i) => RemoveAllTiketUseCase(repository: i()),
    ),

    //BLOCS
    BlocBind.factory<TiketBloc>(
      (i) => TiketBloc(
        getTiketByColetaUseCase: i(),
        createTiketByColetaUseCase: i(),
        updateTiketUseCase: i(),
        removeAllTiketUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => TiketsPage(
        tiketBloc: Modular.get<TiketBloc>(),
        impressoraBloc: Modular.get<ImpressoraBloc>(),
        homeBloc: Modular.get<HomeBloc>(),
        produtorBloc: Modular.get<ProdutorBloc>(),
      ),
    ),
  ];
}
