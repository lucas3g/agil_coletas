import 'package:agil_coletas/app/modules/rotas/rotas_module.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/get_produtores_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/get_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/save_produtores_usecase.dart';
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
    Bind.factory<ITiketRepository>((i) => TiketRepository(datasource: i())),

    //USECASES
    Bind.factory<IGetTiketByColetaUseCase>(
        (i) => GetTiketByColetaUseCase(repository: i())),
    Bind.factory<IGetProdutoresUseCase>(
        (i) => GetProdutoresUseCase(repository: i())),
    Bind.factory<ISaveProdutoresUseCase>(
        (i) => SaveProdutoresUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<TiketBloc>(
      (i) => TiketBloc(
          getTiketByColetaUseCase: i(),
          getProdutoresUseCase: i(),
          saveProdutoresUseCase: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => TiketsPage(
        tiketBloc: Modular.get<TiketBloc>(),
      ),
    ),
  ];
}
