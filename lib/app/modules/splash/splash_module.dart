import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/get_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/save_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/external/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/modules/splash/presenter/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class SplashModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IProdutorDatasource>(
      (i) => ProdutorDatasource(clientHttp: i(), storage: i()),
    ),

    //REPOSITORIES
    Bind.factory<IProdutorRepository>(
      (i) => ProdutorRepository(datasource: i()),
    ),

    //USECASES
    Bind.factory<IGetProdutoresUseCase>(
        (i) => GetProdutoresUseCase(repository: i())),
    Bind.factory<ISaveProdutoresUseCase>(
        (i) => SaveProdutoresUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<ProdutorBloc>(
      (i) => ProdutorBloc(
        getProdutoresUseCase: i(),
        saveProdutoresUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => SplashPage(
        produtorBloc: Modular.get<ProdutorBloc>(),
      ),
    )
  ];
}
