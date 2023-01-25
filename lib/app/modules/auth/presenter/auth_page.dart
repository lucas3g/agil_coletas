// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/states/license_states.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/controller/auth_controller.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:agil_coletas/app/components/my_alert_dialog_widget.dart';
import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/baixa_tudo/baixa_tudo_controller.dart';
import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/license/bloc/license_bloc.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/funcionario_adapter.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/formatters.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;
  final LicenseBloc licenseBloc;
  final IDeviceInfo deviceInfo;

  const AuthPage({
    Key? key,
    required this.authBloc,
    required this.licenseBloc,
    required this.deviceInfo,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final shared = Modular.get<ILocalStorage>();

  late User user;

  final fCNPJ = FocusNode();
  final fLogin = FocusNode();
  final fPassword = FocusNode();

  final gkForm = GlobalKey<FormState>();

  late bool visiblePass = true;

  late StreamSubscription sub;
  late StreamSubscription subLicense;

  Future getDeviceInfo() async {
    final result = await widget.deviceInfo.getDeviceInfo();

    await shared.setData(
        params: SharedParams(key: 'DEVICE_ID', value: result.deviceID));
  }

  @override
  void initState() {
    super.initState();

    getDeviceInfo();

    user = UserAdapter.empty();

    sub = widget.authBloc.stream.listen((state) async {
      if (state is SuccessAuth) {
        await shared.setData(
          params: SharedParams(
            key: 'funcionario',
            value: FuncionarioAdapter.toJson(state.funcionario),
          ),
        );

        await BaixaTudoController.instance.baixaTudo.baixaTudo();

        widget.licenseBloc.add(SaveLicenseEvent());

        Modular.to.navigate('/home/');
      }

      if (state is ErrorAuth) {
        MySnackBar(
          title: 'Atenção',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });

    subLicense = widget.licenseBloc.stream.listen((state) {
      if (state is LicenseActive) {
        widget.authBloc.add(SignInAuthEvent(user: user));
      }

      if (state is LicenseNotActive) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não ativa. Por favor, entre em contato com o suporte.',
          type: ContentType.help,
        );
      }

      if (state is LicenseNotFound) {
        MySnackBar(
          title: 'Atenção',
          message:
              'Licença não encontrada. Por favor, entre em contato com o suporte.',
          type: ContentType.warning,
        );
      }

      if (state is ErrorLicense) {
        MySnackBar(
          title: 'Opss...',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    subLicense.cancel();

    super.dispose();
  }

  Widget retornaLogin(AuthStates state, LicenseStates stateLicense) {
    if (state is LoadingAuth || stateLicense is LoadingLicense) {
      return const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is SuccessAuth) {
      return const Center(
        child: Icon(Icons.done_rounded),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.check_circle_rounded),
        SizedBox(width: 10),
        Text(
          'Entrar',
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    pathLogo,
                    width: context.screenWidth * .8,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Form(
                key: gkForm,
                child: ListView(
                  children: [
                    Text(
                      'Faça o login agora com sua conta',
                      style: AppTheme.textStyles.labelLogin,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      focusNode: fCNPJ,
                      label: 'CNPJ',
                      hintText: 'Digite o CNPJ da empresa',
                      keyboardType: TextInputType.number,
                      value: user.cnpj.value,
                      validator: (v) => user.cnpj.validate().exceptionOrNull(),
                      onChanged: (e) => user.setCNPJ(e),
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CnpjInputFormatter(),
                      ],
                      onFieldSubmitted: (v) => fLogin.requestFocus(),
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      focusNode: fLogin,
                      label: 'Usuário',
                      hintText: 'Digite o seu usuário',
                      value: user.login.value,
                      validator: (v) => user.login.validate().exceptionOrNull(),
                      onChanged: (e) => user.setLogin(e),
                      inputFormaters: [UpperCaseTextFormatter()],
                      onFieldSubmitted: (v) => fPassword.requestFocus(),
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      focusNode: fPassword,
                      label: 'Senha',
                      hintText: 'Digite a sua senha',
                      obscureText: visiblePass,
                      maxLines: 1,
                      value: user.password.value,
                      validator: (v) =>
                          user.password.validate().exceptionOrNull(),
                      onChanged: (e) => user.setPassword(e),
                      inputFormaters: [UpperCaseTextFormatter()],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visiblePass = !visiblePass;
                          });
                        },
                        icon: !visiblePass
                            ? Icon(
                                Icons.visibility,
                                color: AppTheme.colors.primary,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<LicenseBloc, LicenseStates>(
                        bloc: widget.licenseBloc,
                        builder: (context, licenseState) {
                          return BlocBuilder<AuthBloc, AuthStates>(
                            bloc: widget.authBloc,
                            builder: (context, state) {
                              return MyElevatedButtonWidget(
                                height: 40,
                                label: retornaLogin(state, licenseState),
                                onPressed: () {
                                  if (!gkForm.currentState!.validate()) {
                                    return;
                                  }

                                  widget.licenseBloc.add(
                                    VerifyLicenseEvent(
                                      deviceInfo:
                                          GlobalDevice.instance.deviceInfo,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return MyAlertDialogWidget(
                              title: 'Código de Autenticação',
                              content:
                                  GlobalDevice.instance.deviceInfo.deviceID,
                              okButton: MyElevatedButtonWidget(
                                height: 45,
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.whatsapp),
                                    SizedBox(width: 10),
                                    Text('WhatsApp'),
                                  ],
                                ),
                                onPressed: () {
                                  AuthController.openWhatsapp(
                                    text:
                                        'Olá, desejo usar o aplicativo do Ágil Coletas esse é meu codigo de autenticação: ${GlobalDevice.instance.deviceInfo.deviceID}',
                                    number: '+555499712433',
                                  );
                                },
                              ),
                              cancelButton: MyElevatedButtonWidget(
                                height: 45,
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.close),
                                    SizedBox(width: 10),
                                    Text('Fechar'),
                                  ],
                                ),
                                onPressed: () {
                                  Modular.to.pop('dialog');
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Licença para acessar'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'EL Sistemas - 2023 - 054 3364-1588',
                    style: AppTheme.textStyles.labelLogin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
