import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class PrimaryAppBar extends AppBar {
  PrimaryAppBar({
    super.key,
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
              onPressed: () => print('Tela de Alertas'),
            ),
            const SizedBox(width: 37),
            AppBarTextButton(
              text: 'Alertas',
              onPressed: () => print('Tela de Alertas'),
            ),
            const SizedBox(width: 37),
            AppBarTextButton(
              text: 'Conta',
              onPressed: () => print('Tela de Alertas'),
            ),
          ],
        );
}
