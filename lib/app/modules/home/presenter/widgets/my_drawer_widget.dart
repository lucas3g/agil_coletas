// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agil_coletas/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:agil_coletas/app/utils/my_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyDrawerWidget extends StatefulWidget {
  final Funcionario funcionario;

  const MyDrawerWidget({
    Key? key,
    required this.funcionario,
  }) : super(key: key);

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  final authBloc = Modular.get<AuthBloc>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    sub = authBloc.stream.listen((state) {
      if (state is ErrorAuth) {
        MySnackBar(
          title: 'Ops...',
          message: state.message,
          type: ContentType.failure,
        );
      }

      if (state is SuccessSignOutAuth) {
        Modular.to.navigate('/auth/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.white,
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: context.screenHeight * .15,
              color: Colors.white,
              child: Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.white,
                ),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppTheme.colors.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Motorista: ${widget.funcionario.name.value}',
                        style: AppTheme.textStyles.titleDrawer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: context.screenHeight * .85,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.print_rounded,
                          color: AppTheme.colors.primary,
                        ),
                        minLeadingWidth: 10,
                        title: Text(
                          'Impressora',
                          style: AppTheme.textStyles.subtitleDrawer,
                        ),
                        onTap: () {
                          Modular.to.pushNamed('/home/impressoras/');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: AppTheme.colors.primary,
                        ),
                        minLeadingWidth: 10,
                        title: Text(
                          'Configurações',
                          style: AppTheme.textStyles.subtitleDrawer,
                        ),
                        onTap: () {
                          Modular.to.pushNamed('/home/config/');
                        },
                      ),
                      BlocBuilder<AuthBloc, AuthStates>(
                          bloc: authBloc,
                          builder: (context, state) {
                            return ListTile(
                              leading: state is LoadingAuth
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppTheme.colors.primary,
                                      ),
                                    )
                                  : Icon(
                                      Icons.exit_to_app,
                                      color: AppTheme.colors.primary,
                                    ),
                              minLeadingWidth: 10,
                              title: Text(
                                'Sair',
                                style: AppTheme.textStyles.subtitleDrawer,
                              ),
                              onTap: () {
                                authBloc.add(SignOutUserEvent());
                              },
                            );
                          }),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      'Versão 2.0.0',
                      textAlign: TextAlign.end,
                      style: AppTheme.textStyles.subtitleDrawer,
                    ),
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
