import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/custom/aquario_item.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';

class AquarioView extends StatefulWidget {
  const AquarioView({Key? key, required this.aquarioDTO}) : super(key: key);

  final AquarioDTO aquarioDTO;

  @override
  State<AquarioView> createState() => _AquarioViewState();
}

class _AquarioViewState extends State<AquarioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        telaMeusAquarios: true,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90).copyWith(top: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
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
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(child: AquarioItem(widget.aquarioDTO)),
              ),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gráficos',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // TODO: adicionar os gráficos do aquário com a biblioteca syncfusion
            ],
          ),
        ),
      ),
    );
  }
}
