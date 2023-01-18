// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/baixa_tudo/baixa_tudo.dart';
import 'package:agil_coletas/app/core_module/services/connectivity/connectivity_service.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import 'package:agil_coletas/app/app_module.dart';
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late BaixaTudo baixaTudo;

  Future init() async {
    await Modular.isModuleReady<AppModule>();

    await Future.delayed(const Duration(milliseconds: 500));

    if (await ConnectivityService.hasWiFi()) {
      baixaTudo = BaixaTudo(
        rotasBloc: Modular.get<RotasBloc>(),
        produtorBloc: Modular.get<ProdutorBloc>(),
      );

      baixaTudo.baixaTudo();
    }

    final shared = Modular.get<ILocalStorage>();

    final fun = shared.getData('funcionario');

    if (fun != null) {
      return Modular.to.navigate('/home/');
    }

    Modular.to.navigate('/auth/');
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          pathLogo,
          width: context.screenWidth * .9,
        ),
      ),
    );
  }
}
