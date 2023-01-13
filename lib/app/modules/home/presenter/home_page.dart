import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: Text(
          '..: ${GlobalFuncionario.instance.funcionario.empresa.value} :..',
          style: AppTheme.textStyles.titleAppBar,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: context.screenHeight * .10,
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
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
                        'Motorista: ${GlobalFuncionario.instance.funcionario.name.value}',
                        style: AppTheme.textStyles.titleDrawer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: context.screenHeight * .90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Configuração',
                          style: AppTheme.textStyles.subtitleDrawer,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text(
                          'Impressora',
                          style: AppTheme.textStyles.subtitleDrawer,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
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
