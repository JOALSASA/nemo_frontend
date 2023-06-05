import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.icon,
    this.height,
    this.validator,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? icon;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            suffixIcon: icon != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 0, bottom: 15),
                    child: SizedBox(
                      height: 14,
                      child: Image.asset(icon!),
                    ),
                  )
                : null,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: PaletaCores.azul3,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: PaletaCores.azul3,
                width: 2,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }
}
