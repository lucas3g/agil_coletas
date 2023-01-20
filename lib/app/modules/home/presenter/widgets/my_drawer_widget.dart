// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';

class MyDrawerWidget extends StatelessWidget {
  final Funcionario funcionario;

  const MyDrawerWidget({
    Key? key,
    required this.funcionario,
  }) : super(key: key);

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
                        'Motorista: ${funcionario.name.value}',
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
                          Icons.settings,
                          color: AppTheme.colors.primary,
                        ),
                        minLeadingWidth: 10,
                        title: Text(
                          'Configuração',
                          style: AppTheme.textStyles.subtitleDrawer,
                        ),
                        onTap: () {},
                      ),
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
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: AppTheme.colors.primary,
                        ),
                        minLeadingWidth: 10,
                        title: Text(
                          'Sair',
                          style: AppTheme.textStyles.subtitleDrawer,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      'Versão 1.0.0',
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
