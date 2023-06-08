import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/custom/aquario_item.dart';
import 'package:nemo_frontend/components/inputs/search_bar.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/models/aquario_dto.dart';
import 'package:nemo_frontend/models/usuario_dto.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.usuario}) : super(key: key);

  final UsuarioDTO usuario;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  AquarioDAO aquarioDAO = AquarioDAO();

  List<AquarioDTO> listaAquarios = [
    AquarioDTO(id: 1, nome: 'Aquário 1', altura: 1, comprimento: 2, largura: 3),
    AquarioDTO(id: 2, nome: 'Aquário 2', altura: 2, comprimento: 2, largura: 2),
    AquarioDTO(id: 3, nome: 'Aquário 3', altura: 1, comprimento: 4, largura: 1),
  ];

  @override
  void initState() {
    super.initState();
    aquarioDAO.listarAquariosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        meusAquarios: _navegarTelaMeusAquarios,
        alertas: _navegarTelaAlertas,
        conta: _navegarTelaConta,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const CustomSearchBar(),
                  ),
                  const SizedBox(width: 15),
                  PrimaryButton(
                    onPressed: () {},
                    backgroundColor: PaletaCores.azul2,
                    text: 'Buscar',
                    fontSize: 16,
                  ),
                ],
              ),
              const SizedBox(height: 45),
              PrimaryButton(
                onPressed: () {},
                backgroundColor: PaletaCores.azul2,
                text: 'Adicionar aquário',
                fontSize: 16,
              ),
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Número de colunas desejado
                  crossAxisSpacing: 10, // Espaçamento horizontal entre os itens
                  mainAxisSpacing: 10, // Espaçamento vertical entre os itens
                  childAspectRatio: 16 / 9
                ),
                itemCount: listaAquarios.length,
                itemBuilder: (context, index) => Align(child: AquarioItem(listaAquarios[index])),
              ),
            ],
          ),
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
