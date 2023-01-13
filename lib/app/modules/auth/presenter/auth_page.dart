import 'dart:async';

import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/components/my_input_widget.dart';
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;

  const AuthPage({
    Key? key,
    required this.authBloc,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late User user;

  final fCNPJ = FocusNode();
  final fLogin = FocusNode();
  final fPassword = FocusNode();

  late bool visiblePass = true;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    user = UserAdapter.empty();

    sub = widget.authBloc.stream.listen((state) {
      if (state is ErrorAuth) {
        MySnackBar(
          title: 'Atenção',
          message: state.message,
          type: ContentType.failure,
        );
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SvgPicture.asset(
                pathLogo,
                width: context.screenWidth * .9,
              ),
            ),
            const Spacer(),
            Text(
              'Faça o login agora com sua conta',
              style: AppTheme.textStyles.labelLogin,
            ),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              children: [
                MyInputWidget(
                  focusNode: fCNPJ,
                  label: 'CNPJ',
                  hintText: 'Digite o CNPJ da empresa',
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
                  validator: (v) => user.password.validate().exceptionOrNull(),
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
                BlocBuilder<AuthBloc, AuthStates>(
                  bloc: widget.authBloc,
                  builder: (context, state) {
                    return MyElevatedButtonWidget(
                      label: state is LoadingAuth
                          ? const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check_circle_rounded),
                                SizedBox(width: 10),
                                Text('Entrar')
                              ],
                            ),
                      onPressed: () {
                        widget.authBloc.add(SignInAuthEvent(user: user));
                      },
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Text(
              'EL Sistemas - 2022 - 054 3364-1588',
              style: AppTheme.textStyles.labelLogin,
            ),
          ],
        ),
      ),
    );
  }
}
