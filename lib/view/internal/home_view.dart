import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
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
    return Scaffold(
      appBar: PrimaryAppBar(
        meusAquarios: _navegarTelaMeusAquarios,
        alertas: _navegarTelaAlertas,
        conta: _navegarTelaConta,
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [SearchBar()],
        ),
      ),
    );
  }

  void _navegarTelaAlertas() {
    print('Tela de Alertas');
  }

  void _navegarTelaMeusAquarios() {
    print('Tela de Alerts');
  }

  void _navegarTelaConta() {
    print('Tela de Alertas');
  }
}
