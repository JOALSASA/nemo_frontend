import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/custom/reusable_future_builder.dart';
import 'package:nemo_frontend/components/dialogs/fail_dialog.dart';
import 'package:nemo_frontend/components/dialogs/success_dialog.dart';
import 'package:nemo_frontend/components/inputs/custom_form_field.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/components/utils/snack_bar_utils.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/dao/usuario_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/models/aquario/novo_aquario_form.dart';
import 'package:nemo_frontend/models/usuario/usuario_dto.dart';

class PartilharAquarioDialog extends StatefulWidget {
  const PartilharAquarioDialog({Key? key, required this.idAquario})
      : super(key: key);

  final int idAquario;

  @override
  State<PartilharAquarioDialog> createState() => _PartilharAquarioDialogState();
}

class _PartilharAquarioDialogState extends State<PartilharAquarioDialog> {
  final UsuarioDAO _usuarioDAO = UsuarioDAO();
  final AquarioDAO _aquarioDAO = AquarioDAO();

  final TextEditingController _nomeController = TextEditingController();
  Future<List<UsuarioDTO>>? _futureUsuariosDtos;

  @override
  void initState() {
    _futureUsuariosDtos = _usuarioDAO.consultarUsuarioPorNome("0");
    _nomeController.addListener(() {
      if (_nomeController.text.isNotEmpty) {
        setState(() {
          _futureUsuariosDtos =
              _usuarioDAO.consultarUsuarioPorNome(_nomeController.text);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.30),
      backgroundColor: PaletaCores.azul2,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Partilhar aquário',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 15),
            CustomFormField(
                controller: _nomeController,
                hintText: 'Nome do usuário',
                keyboardType: TextInputType.text),
            const SizedBox(height: 10),
            ReusableFutureBuilder(
                future: _futureUsuariosDtos!,
                textColor: Colors.white,
                builder: (context, snapshot) {
                  List<UsuarioDTO> usuarioDtos = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: usuarioDtos.length,
                    itemBuilder: (context, index) =>
                        usuarioAutorizadoItem(usuarioDtos[index]),
                  );
                }),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                PrimaryButton(
                  onPressed: () => Navigator.pop(context, false),
                  fontSize: 16,
                  text: 'Cancelar',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget usuarioAutorizadoItem(UsuarioDTO usuarioDTO) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${usuarioDTO.nome}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () => partilharAquario(usuarioDTO),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                      Image.asset(
                        'assets/icons/cruz_icon.png',
                      ).image,
                      size: 14,
                      color: PaletaCores.azul3),
                  const Text(
                    'Adicionar',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void partilharAquario(UsuarioDTO usuarioDTO) async {
    try {
      await _aquarioDAO.partilharAquario(widget.idAquario, usuarioDTO.id ?? 0);

      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => const SuccessDialog(
              message: 'Aquário foi partilhado com sucesso'),
        );
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
