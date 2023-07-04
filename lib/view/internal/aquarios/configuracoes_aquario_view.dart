import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/custom/aquario_item.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.aquarioDTO.nome}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
