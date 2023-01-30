import 'package:agil_coletas/app/components/my_app_bar_widget.dart';
import 'package:agil_coletas/app/components/my_elevated_button_widget.dart';
import 'package:agil_coletas/app/core_module/services/apagar_tudo/apagar_tudo_controller.dart';
import 'package:agil_coletas/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: MyAppBarWidget(
          titleAppbar: 'Configuração',
          backButton: BackButton(
            color: Colors.white,
            onPressed: () {
              Modular.to.navigate('/home/');
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            const ListTile(
              title: Text('Apagar base dados?'),
              subtitle: Text(
                  'Isso irá apagar todas as coletas. O aplicativo irá se fechar.'),
            ),
            Row(
              children: [
                Expanded(
                  child: MyElevatedButtonWidget(
                    label: const Text('Voltar'),
                    onPressed: () {
                      Modular.to.navigate('/home/');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyElevatedButtonWidget(
                    label: const Text('Apagar'),
                    onPressed: () async {
                      await ApagarTudoController.apagarTudo();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
