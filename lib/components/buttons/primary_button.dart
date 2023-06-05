import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required void Function()? onPressed,
    required String text,
    bool? disable,
    double? fontSize,
    double? width,
    double? height,
  })  : _height = height,
        _width = width,
        _disable = disable ?? false,
        _text = text,
        _fontSize = fontSize,
        _onPressed = onPressed,
        super(key: key);

  final void Function()? _onPressed;
  final String _text;
  final bool _disable;
  final double? _fontSize;
  final double? _width;
  final double? _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: ElevatedButton(
        onPressed: _disable ? null : _onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: PaletaCores.azul3,
        ),
        child: Text(
          _text,
          style: TextStyle(
            color: Colors.white,
            fontSize: _fontSize ?? 24,
          ),
        ),
      ),
    );
  }
}
