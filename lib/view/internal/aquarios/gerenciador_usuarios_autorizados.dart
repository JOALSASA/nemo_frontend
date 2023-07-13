import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/custom/reusable_future_builder.dart';
import 'package:nemo_frontend/components/dialogs/fail_dialog.dart';
import 'package:nemo_frontend/components/dialogs/question_dialog.dart';
import 'package:nemo_frontend/components/dialogs/success_dialog.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/models/usuario/usuario_dto.dart';

class GerenciadorUsuariosAutorizados extends StatefulWidget {
  const GerenciadorUsuariosAutorizados({required this.aquarioDTO, Key? key})
      : super(key: key);

  final AquarioDTO aquarioDTO;

  @override
  State<GerenciadorUsuariosAutorizados> createState() =>
      _GerenciadorUsuariosAutorizadosState();
}

class _GerenciadorUsuariosAutorizadosState
    extends State<GerenciadorUsuariosAutorizados> {
  final AquarioDAO _aquarioDAO = AquarioDAO();
  Future<List<UsuarioDTO>>? _futureListUsuario;

  @override
  void initState() {
    _futureListUsuario =
        _aquarioDAO.listarUsuariosPermissaoAquario(widget.aquarioDTO.id ?? 0);
    super.initState();
  }

  void _fetchUsuariosPermisoes() {
    setState(() {
      _futureListUsuario =
          _aquarioDAO.listarUsuariosPermissaoAquario(widget.aquarioDTO.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 580, minWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Usuários autorizados',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.50),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(child: Row()),
                ReusableFutureBuilder(
                  future: _futureListUsuario!,
                  builder: (context, snapshot) {
                    List<UsuarioDTO> usuariosAutorizados = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: usuariosAutorizados.length,
                      itemBuilder: (context, index) =>
                          usuariosAutorizadosItem(usuariosAutorizados[index]),
                    );
                  },
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  onPressed: () {},
                  backgroundColor: PaletaCores.azul2,
                  text: 'Adicionar usuário',
                  fontSize: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget usuariosAutorizadosItem(UsuarioDTO usuarioDTO) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${usuarioDTO.nome}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF022859),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () => _removerUsuarioAutorizado(usuarioDTO.id ?? 0),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/lixeira_icon.png',
                    width: 14,
                    height: 16,
                    fit: BoxFit.fill,
                  ),
                  const Text(
                    'Remover',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removerUsuarioAutorizado(int idUsuario) async {
    try {
      bool result = await showDialog(
        context: context,
        builder: (context) => const QuestionDialog(
            message: 'Tem certeza que deseja remover este usuário?'),
      );

      if (!result) {
        return;
      }

      await _aquarioDAO.deletarUsuarioAutorizado(
          widget.aquarioDTO.id ?? 0, idUsuario);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) =>
              const SuccessDialog(message: 'Valor cadastrado com sucesso.'),
        ).then((value) {
          setState(() {
            _fetchUsuariosPermisoes();
          });
        });
      }
    } on ApiErroDTO catch (exception, stacktrace) {
      showDialog(
        context: context,
        builder: (context) => FailDialog(message: exception.mensagem ?? ''),
      );
      debugPrint('$exception\n$stacktrace');
    }
  }
}
