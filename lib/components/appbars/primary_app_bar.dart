import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/view/internal/alertas/meus_alertas_view.dart';
import 'package:nemo_frontend/view/internal/conta/conta_view.dart';
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
                        const MeusAlertasView(),
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

                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const ContaView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ));
                }),
          ],
        );
}
