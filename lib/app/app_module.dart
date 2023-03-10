import 'package:agil_coletas/app/core_module/core_module.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/get_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/remove_all_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/save_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/external/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/modules/auth/auth_module.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signout_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/modules/home/home_module.dart';
import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/get_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/remove_all_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/save_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/external/datasource/rotas_datasource.dart';
import 'package:agil_coletas/app/modules/rotas/infra/datasources/rotas_datasource.dart';
import 'package:agil_coletas/app/modules/rotas/infra/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/splash/splash_module.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/create_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/get_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/remove_all_tikets_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/update_tiket_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/external/tiket_datasource.dart';
import 'package:agil_coletas/app/modules/tikets/infra/datasources/tiket_datasource.dart';
import 'package:agil_coletas/app/modules/tikets/infra/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/tiket_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/get_transportador_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/remove_all_transportadores_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/save_transportador_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/external/datasources/transportador_datasource.dart';
import 'package:agil_coletas/app/modules/transportador/infra/datasources/transportador_datasouce.dart';
import 'package:agil_coletas/app/modules/transportador/infra/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
    HomeModule(),
  ];

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
      (i) => GetProdutoresUseCase(repository: i()),
    ),
    Bind.factory<ISaveProdutoresUseCase>(
      (i) => SaveProdutoresUseCase(repository: i()),
    ),
    Bind.factory<IRemoveAllProdutoresUseCase>(
      (i) => RemoveAllProdutoresUseCase(repository: i()),
    ),

    //BLOCS
    BlocBind.factory<ProdutorBloc>(
      (i) => ProdutorBloc(
        getProdutoresUseCase: i(),
        saveProdutoresUseCase: i(),
        removeAllProdutoresUseCase: i(),
      ),
    ),

    //DATASOURCES
    Bind.factory<IRotasDatasource>(
      (i) => RotasDatasource(clientHttp: i(), storage: i()),
    ),

    //REPOSITORIES
    Bind.factory<IRotasRepository>((i) => RotasRepository(datasource: i())),

    //USECASES
    Bind.factory<IGetRotasUseCase>((i) => GetRotasUseCase(repository: i())),
    Bind.factory<ISaveRotasUseCase>((i) => SaveRotasUseCase(repository: i())),
    Bind.factory<IRemoveAllRotasUseCase>(
        (i) => RemoveAllRotasUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<RotasBloc>(
      (i) => RotasBloc(
        getRotasUseCase: i(),
        saveRotasUseCase: i(),
        removeAllRotasUseCase: i(),
      ),
    ),

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
    Bind.factory<ISaveTransportadorUseCase>(
        (i) => SaveTransportadorUseCase(repository: i())),
    Bind.factory<IRemoveAllTransportadorUseCase>(
        (i) => RemoveAllTransportadorUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<TransportadorBloc>(
      (i) => TransportadorBloc(
        getTransportadorUseCase: i(),
        saveTransportadorUseCase: i(),
        removeAllTransportadorUseCase: i(),
      ),
    ),

    //DATASOURCES
    Bind.factory<IAuthDatasource>(
        (i) => AuthDatasource(clientHttp: i(), localStorage: i())),

    //REPOSITORIES
    Bind.factory<IAuthRepository>((i) => AuthRepository(datasource: i())),

    //USECASES
    Bind.factory<ISignInUserUseCase>(
      (i) => SignInUserUseCase(repository: i()),
    ),
    Bind.factory<ISignOutUserUseCase>(
      (i) => SignOutUserUseCase(repository: i()),
    ),

    //BLOC
    BlocBind.factory<AuthBloc>(
      (i) => AuthBloc(
        signInUserUseCase: i(),
        signOutUserUseCase: i(),
      ),
    ),

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
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute(
      '/auth',
      module: AuthModule(),
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 600),
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 600),
    ),
  ];
}
