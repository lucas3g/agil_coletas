import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final funcionario = GlobalFuncionario.instance.funcionario;

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
          '..: ${funcionario.empresa.nome} :..',
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
      drawer: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.white,
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: context.screenHeight * .10,
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
                height: context.screenHeight * .90,
                color: Colors.white,
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'botao1',
              onPressed: () {},
              child: const Icon(Icons.cloud_upload_rounded),
            ),
            FloatingActionButton(
              heroTag: 'botao2',
              onPressed: () {
                Modular.to.pushNamed('/home/rotas/');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
