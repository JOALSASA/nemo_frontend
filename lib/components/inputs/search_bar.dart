import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 12),
        suffixIcon: const Icon(Icons.search),
        hintText: 'Ex: Aquário de nemos',
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
        ),
      ),
    );
  }

}
