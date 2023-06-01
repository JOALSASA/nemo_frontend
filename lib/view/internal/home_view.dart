import 'package:flutter/material.dart';
import 'package:nemo_frontend/models/usuario_dto.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.usuario}) : super(key: key);

  final UsuarioDTO usuario;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
