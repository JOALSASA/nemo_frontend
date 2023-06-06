import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class PrimaryAppBar extends AppBar {
  PrimaryAppBar({
    super.key,
    required void Function()? meusAquarios,
    required void Function()? alertas,
    required void Function()? conta,
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
                text: 'Meus aquários', onPressed: () => meusAquarios),
            AppBarTextButton(text: 'Alertas', onPressed: () => alertas),
            AppBarTextButton(text: 'Conta', onPressed: () => conta),
          ],
        );
}
