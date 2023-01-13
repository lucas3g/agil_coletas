import 'package:agil_coletas/app/core_module/core_module.dart';
import 'package:agil_coletas/app/modules/auth/auth_module.dart';
import 'package:agil_coletas/app/modules/home/home_module.dart';
import 'package:agil_coletas/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
    HomeModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
