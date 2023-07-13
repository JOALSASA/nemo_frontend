import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/custom/aquario_item.dart';
import 'package:nemo_frontend/components/custom/grafico_aquario.dart';
import 'package:nemo_frontend/components/custom/reusable_future_builder.dart';
import 'package:nemo_frontend/dao/aquario_parametro_dao.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/models/parametro/aquario_parametro_dto.dart';
import 'package:nemo_frontend/models/usuario/usuario_dto.dart';

class AquarioView extends StatefulWidget {
  const AquarioView({Key? key, required this.aquarioDTO, required this.usuarioDTO}) : super(key: key);

  final AquarioDTO aquarioDTO;
  final UsuarioDTO usuarioDTO;

  @override
  State<AquarioView> createState() => _AquarioViewState();
}

class _AquarioViewState extends State<AquarioView> {
  final AquarioParametroDAO _aquarioParametroDAO = AquarioParametroDAO();
  Future<List<AquarioParametroDTO>>? futureAquarioParametroDTOs;

  @override
  void initState() {
    fetchAquarioParametros();
    super.initState();
  }

  void fetchAquarioParametros() {
    futureAquarioParametroDTOs =
        _aquarioParametroDAO.listarParametrosAquario(widget.aquarioDTO.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 30),
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
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(child: AquarioItem(widget.aquarioDTO)),
              ),
              const SizedBox(height: 25),
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
              ReusableFutureBuilder(
                  future: futureAquarioParametroDTOs!,
                  builder: (context, snapshot) {
                    List<AquarioParametroDTO> aquarioParametroDTOs =
                        snapshot.data!;
                    return GridView.builder(
                        padding: const EdgeInsets.only(left: 176, right: 173),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width ~/ 700,
                          crossAxisSpacing: 82,
                          mainAxisSpacing: 56,
                          childAspectRatio: 250 / 145,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GraficoAquario(
                            aquarioParametroDTO: aquarioParametroDTOs[index],
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
