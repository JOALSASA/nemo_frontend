import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/main.dart';
import 'package:nemo_frontend/utils/local_storage.dart';
import 'package:nemo_frontend/view/internal/alertas/alertas_view.dart';
import 'package:nemo_frontend/view/internal/home_view.dart';

class PrimaryAppBar extends AppBar {
  PrimaryAppBar({
    super.key,
    required BuildContext context,
    bool telaMeusAquarios = false,
    bool telaAlertas = false,
    bool telaConta = false,
  }) : super(
          backgroundColor: PaletaCores.azul1,
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          title: Container(
            margin: const EdgeInsets.only(left: 85),
            child: const Text(
              'NEMO',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          actions: [
            AppBarTextButton(
                text: 'Meus aquários',
                decoration: telaMeusAquarios ? TextDecoration.underline : null,
                onPressed: () {
                  if (telaMeusAquarios) {
                    return;
                  }
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const HomeView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ));
                }),
            const SizedBox(width: 37),
            AppBarTextButton(
                text: 'Alertas',
                decoration: telaAlertas ? TextDecoration.underline : null,
                onPressed: () {
                  if (telaAlertas) {
                    return;
                  }

                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const AlertasView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ));
                }),
            const SizedBox(width: 37),
            AppBarTextButton(
                text: 'Conta',
                decoration: telaConta ? TextDecoration.underline : null,
                onPressed: () {
                  if (telaConta) {
                    return;
                  }
                  showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(100, 80, 10, 100),
                    items: [
                      PopupMenuItem<String>(
                        child: const Text('Sair'),
                        onTap: () async {
                          await LocalStorage.clearStorage();
                          navigatorKey.currentState!
                              .pushReplacementNamed('/boas-vindas');
                        },
                      ),
                    ],
                    elevation: 8.0,
                  );
                }),
          ],
        );
}
