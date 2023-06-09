import 'package:flutter/material.dart';

class AppBarTextButton extends StatelessWidget {
  const AppBarTextButton(
      {Key? key, required this.text, required this.onPressed, this.decoration})
      : super(key: key);

  final String text;
  final void Function()? onPressed;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          decoration: decoration,
          decorationColor: Colors.white,
        ),
      ),
      onPressed: () => onPressed?.call(),
    );
  }
}
