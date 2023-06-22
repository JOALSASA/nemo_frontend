import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class FailDialog extends StatelessWidget {
  const FailDialog({Key? key, required this.message}) : super(key: key);

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
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(color: PaletaCores.azul1, fontSize: 16),
            ),
            const SizedBox(height: 15),
            PrimaryButton(onPressed: () => Navigator.pop(context), text: 'Ok'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
