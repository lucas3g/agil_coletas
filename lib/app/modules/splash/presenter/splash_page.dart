// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/core_module/services/baixa_tudo/baixa_tudo_controller.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';
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
  late AuthBloc authBloc;
  late StreamSubscription sub;
  late dynamic fun;

  Future init() async {
    await Modular.isModuleReady<AppModule>();

    await Future.delayed(const Duration(seconds: 1));

    final shared = Modular.get<ILocalStorage>();

    fun = shared.getData('funcionario');

    if (fun != null) {
      authBloc = Modular.get<AuthBloc>();

      authBloc.add(
          VerifyLicenseEvent(deviceInfo: GlobalDevice.instance.deviceInfo));

      await BaixaTudoController.instance.baixaTudo.baixaTudo();
      return Modular.to.navigate('/home/');
    }

    Modular.to.navigate('/auth/');
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await init();

      if (fun != null) {
        sub = authBloc.stream.listen((state) {
          if (state is LicenseActiveAuth) {
            authBloc.add(SaveLicenseEvent());
          }
        });
      }
    });
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
