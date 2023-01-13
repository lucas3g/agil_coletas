import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/presenter/auth_page.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class AuthModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IAuthDatasource>((i) => AuthDatasource(clientHttp: i())),

    //REPOSITORIES
    Bind.factory<IAuthRepository>((i) => AuthRepository(datasource: i())),

    //USECASES
    Bind.factory<ISignInUserUseCase>((i) => SignInUserUseCase(repository: i())),

    //BLOC
    BlocBind.factory<AuthBloc>((i) => AuthBloc(useCase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => AuthPage(
        authBloc: Modular.get<AuthBloc>(),
        deviceInfo: Modular.get<IDeviceInfo>(),
      ),
    )
  ];
}
