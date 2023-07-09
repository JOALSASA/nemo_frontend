import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.30,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.info_outline_rounded,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(color: PaletaCores.azul1, fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                    onPressed: () => Navigator.pop(context, true),
                    text: 'Continuar'),
                const SizedBox(width: 10),
                PrimaryButton(
                    onPressed: () => Navigator.pop(context, false),
                    text: 'Cancelar'),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
