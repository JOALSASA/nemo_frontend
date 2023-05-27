import 'package:flutter/material.dart';

class IconTextFormField extends StatefulWidget {
  const IconTextFormField({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required String iconName,
    String? passwordVisibleIconName,
    String? passwordHiddenIconName,
    String? Function(String?)? validator,
    isPasswordField = false,
  })  : _controller = controller,
        _validator = validator,
        _hintText = hintText,
        _isPasswordField = isPasswordField,
        _iconName = iconName,
        _passwordVisibleIconName = passwordVisibleIconName ?? iconName,
        _passwordHiddenIconName = passwordHiddenIconName ?? iconName,
        super(key: key);

  final TextEditingController _controller;
  final String? Function(String?)? _validator;
  final String _hintText;
  final String _iconName;
  final bool _isPasswordField;
  final String _passwordVisibleIconName;
  final String _passwordHiddenIconName;


  @override
  State<IconTextFormField> createState() => _IconTextFormFieldState();
}

class _IconTextFormFieldState extends State<IconTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      keyboardType: TextInputType.text,
      validator: widget._validator,
      obscureText: _isPasswordVisible,
      decoration: InputDecoration(
        hintText: widget._hintText,
        filled: true,
        suffixIcon: suffixIconManager(),
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget suffixIconManager() {
    if (!widget._isPasswordField || widget._controller.text.isEmpty) {
      return Image.asset("assets/icons/${widget._iconName}.png");
    }

    return IconButton(
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
      icon: Image.asset("assets/icons/${widget._iconName}.png"),
    );
  }
}
