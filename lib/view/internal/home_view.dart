import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/custom/aquario_item.dart';
import 'package:nemo_frontend/components/dialogs/cadastro_aquario_dialog.dart';
import 'package:nemo_frontend/components/dialogs/success_dialog.dart';
import 'package:nemo_frontend/components/inputs/search_bar.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/view/internal/aquarios/aquario_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AquarioDAO _aquarioDAO = AquarioDAO();
  final TextEditingController searchBarController = TextEditingController();

  Future<List<AquarioDTO>>? _listaAquarios;

  @override
  void initState() {
    super.initState();
    _listaAquarios = _aquarioDAO.listarAquariosUsuario();

    searchBarController.addListener(() {
      if (searchBarController.text.isEmpty) {
        setState(() {
          _listaAquarios = _aquarioDAO.listarAquariosUsuario();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      appBar: PrimaryAppBar(
        telaMeusAquarios: true,
        context: context,
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
                    child: CustomSearchBar(controller: searchBarController),
                  ),
                  const SizedBox(width: 15),
                  PrimaryButton(
                    onPressed: buscarAquario,
                    backgroundColor: PaletaCores.azul2,
                    text: 'Buscar',
                    fontSize: 16,
                  ),
                ],
              ),
              const SizedBox(height: 45),
              PrimaryButton(
                onPressed: () => adicionarNovoAquario(),
                backgroundColor: PaletaCores.azul2,
                text: 'Adicionar aquário',
                fontSize: 16,
              ),
              FutureBuilder<List<AquarioDTO>>(
                future: _listaAquarios,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<AquarioDTO> listaAquarios = snapshot.data!;

                  if (listaAquarios.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.5),
                        child: const Text(
                            'Não encontramos nenhum aquário, tente cadastrar um novo selecionando a opção de adicionar aquário'),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // Número de colunas desejado
                            crossAxisSpacing: 10,
                            // Espaçamento horizontal entre os itens
                            mainAxisSpacing: 10,
                            // Espaçamento vertical entre os itens
                            childAspectRatio: 16 / 9),
                    itemCount: listaAquarios.length,
                    itemBuilder: (context, index) => Align(
                      child: AquarioItem(
                        listaAquarios[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AquarioView(aquarioDTO: listaAquarios[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buscarAquario() {
    if (searchBarController.text.isEmpty) {
      return;
    }

    setState(() {
      _listaAquarios =
          _aquarioDAO.listarAquariosUsuario(searchBarController.text);
    });
  }

  void adicionarNovoAquario() async {
    var result = await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => const CadastroAquarioDialog(),
    );

    if (result != null && (result as bool) && context.mounted) {
      await showDialog(
        context: context,
        builder: (context) => const SuccessDialog(
            message:
                'Parabéns pelo novo cadastro do seu aquário no nosso sistema de gerenciamento de aquários online!'),
      );
      setState(() {
        _listaAquarios = _aquarioDAO.listarAquariosUsuario();
      });
    }
  }
}
