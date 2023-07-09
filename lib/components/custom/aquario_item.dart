import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/view/internal/aquarios/configuracoes_aquario_view.dart';

class AquarioItem extends StatelessWidget {
  const AquarioItem(this.aquario, {Key? key, this.onTap}) : super(key: key);

  final AquarioDTO aquario;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: PaletaCores.branco1,
            borderRadius: BorderRadius.circular(15)),
        constraints: const BoxConstraints(maxHeight: 290, maxWidth: 590),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${aquario.nome}',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Conectado',
                        style: TextStyle(color: PaletaCores.verde1),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: PaletaCores.verde1,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Largura: ${aquario.largura}cm',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Altura: ${aquario.altura}cm',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Comprimento: ${aquario.comprimento}cm',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Volume: ${aquario.altura}m',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/imagem_aquario.png',
                    width: 100,
                    height: 100,
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          ConfiguracoesAquarioView(aquarioDTO: aquario),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('Configurações'), Icon(Icons.settings)],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
