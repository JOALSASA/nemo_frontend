import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/custom/sombra_default.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;

  const CustomSnackBar({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [SombraDefault()],
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
