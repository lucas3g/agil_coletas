import 'dart:async';

import 'package:agil_coletas/app/core_module/services/baixa_tudo/baixa_tudo_controller.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/events/impressora_events.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/impressora_bloc.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/states/impressora_state.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/states/license_states.dart';
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
  late LicenseBloc licenseBloc;
  late ImpressoraBloc impressoraBloc;
  late StreamSubscription sub;
  late StreamSubscription subImp;
  late dynamic fun;

  Future init() async {
    await _checkModuleReady();
    await _delay();
    await _initImpressoraBloc();
    await _checkFuncionario();
  }

  Future _checkModuleReady() async {
    await Modular.isModuleReady<AppModule>();
  }

  Future _delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future _initImpressoraBloc() async {
    impressoraBloc = Modular.get<ImpressoraBloc>();

    if (!GlobalImpressora.instance.impressora.address.contains('address')) {
      impressoraBloc.add(VerificaStatusImpressoraEvent());
    }

    subImp = impressoraBloc.stream.listen((state) {
      if (state is ImpressoraStatus) {
        if (!state.status) {
          impressoraBloc.add(
            ConnectImpressoraEvent(
              imp: GlobalImpressora.instance.impressora,
            ),
          );
        }
      }

      if (state is SuccessConnectImpressora) {
        impressoraBloc.add(SaveImpressoraLocalStorageEvent(imp: state.imp));
      }
    });
  }

  Future _checkFuncionario() async {
    final shared = Modular.get<ILocalStorage>();
    fun = shared.getData('funcionario');

    if (fun != null) {
      await _initLicenseBloc();
      await _baixaTudo();
      Modular.to.navigate('/home/');
      return;
    }

    Modular.to.navigate('/auth/');
  }

  Future _initLicenseBloc() async {
    licenseBloc = Modular.get<LicenseBloc>();
    licenseBloc
        .add(VerifyLicenseEvent(deviceInfo: GlobalDevice.instance.deviceInfo));

    sub = licenseBloc.stream.listen((state) {
      if (state is LicenseActive) {
        licenseBloc.add(SaveLicenseEvent());
      }
    });
  }

  Future _baixaTudo() async {
    await BaixaTudoController.instance.baixaTudo.baixaTudo();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await init();
    });
  }

  @override
  void dispose() {
    if (fun != null) {
      sub.cancel();
    }
    subImp.cancel();

    super.dispose();
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
