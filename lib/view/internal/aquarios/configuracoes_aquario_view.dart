import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/view/internal/aquarios/gerenciador_parametro_aquario.dart';
import 'package:nemo_frontend/view/internal/aquarios/gerenciador_usuarios_autorizados.dart';

class ConfiguracoesAquarioView extends StatefulWidget {
  const ConfiguracoesAquarioView({Key? key, required this.aquarioDTO})
      : super(key: key);

  final AquarioDTO aquarioDTO;

  @override
  State<ConfiguracoesAquarioView> createState() =>
      _ConfiguracoesAquarioViewState();
}

class _ConfiguracoesAquarioViewState extends State<ConfiguracoesAquarioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90).copyWith(top: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.aquarioDTO.nome}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GerenciadorParametroAquario(aquarioDTO: widget.aquarioDTO),
                  const Spacer(),
                  const GerenciadorUsuariosAutorizados(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
