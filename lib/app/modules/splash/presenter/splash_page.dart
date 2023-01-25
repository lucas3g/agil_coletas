// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    await Modular.isModuleReady<AppModule>();

    await Future.delayed(const Duration(seconds: 1));

    impressoraBloc = Modular.get<ImpressoraBloc>();

    if (!GlobalImpressora.instance.impressora.address.contains('address')) {
      impressoraBloc.add(VerificaStatusImpressoraEvent());
    }

    final shared = Modular.get<ILocalStorage>();

    fun = shared.getData('funcionario');

    if (fun != null) {
      licenseBloc = Modular.get<LicenseBloc>();

      licenseBloc.add(
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
        sub = licenseBloc.stream.listen((state) {
          if (state is LicenseActive) {
            licenseBloc.add(SaveLicenseEvent());
          }
        });

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
