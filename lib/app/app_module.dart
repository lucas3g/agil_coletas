import 'package:agil_coletas/app/core_module/core_module.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/get_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/save_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/external/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/datasources/produtor_datasource.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/modules/auth/auth_module.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/modules/home/home_module.dart';
import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/get_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/save_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/external/datasource/rotas_datasource.dart';
import 'package:agil_coletas/app/modules/rotas/infra/datasources/rotas_datasource.dart';
import 'package:agil_coletas/app/modules/rotas/infra/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/splash/splash_module.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/get_transportador_usecase.dart';
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

    //BLOCS
    BlocBind.factory<ProdutorBloc>(
      (i) => ProdutorBloc(
        getProdutoresUseCase: i(),
        saveProdutoresUseCase: i(),
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

    //BLOCS
    BlocBind.factory<RotasBloc>(
      (i) => RotasBloc(
        getRotasUseCase: i(),
        saveRotasUseCase: i(),
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

    //BLOCS
    BlocBind.factory<TransportadorBloc>(
      (i) => TransportadorBloc(
        getTransportadorUseCase: i(),
        saveTransportadorUseCase: i(),
      ),
    ),

    //DATASOURCES
    Bind.factory<IAuthDatasource>((i) => AuthDatasource(clientHttp: i())),

    //REPOSITORIES
    Bind.factory<IAuthRepository>((i) => AuthRepository(datasource: i())),

    //USECASES
    Bind.factory<ISignInUserUseCase>((i) => SignInUserUseCase(repository: i())),

    //BLOC
    BlocBind.factory<AuthBloc>(
      (i) => AuthBloc(
        signInUserUseCase: i(),
        verifyLicenseUseCase: i(),
        saveLicenseUseCase: i(),
        getDateLicenseUseCase: i(),
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
