import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: PaletaCores.azul2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        constraints: const BoxConstraints(maxHeight: 37),
        suffixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: 'Ex: Aquário de nemos',
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

}
