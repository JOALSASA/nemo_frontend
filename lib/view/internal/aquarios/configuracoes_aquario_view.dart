import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/dialogs/fail_dialog.dart';
import 'package:nemo_frontend/components/dialogs/question_dialog.dart';
import 'package:nemo_frontend/components/dialogs/success_dialog.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/view/internal/aquarios/gerenciador_parametro_aquario.dart';
import 'package:nemo_frontend/view/internal/aquarios/gerenciador_usuarios_autorizados.dart';
import 'package:nemo_frontend/view/internal/home_view.dart';

class ConfiguracoesAquarioView extends StatefulWidget {
  const ConfiguracoesAquarioView({Key? key, required this.aquarioDTO})
      : super(key: key);

  final AquarioDTO aquarioDTO;

  @override
  State<ConfiguracoesAquarioView> createState() =>
      _ConfiguracoesAquarioViewState();
}

class _ConfiguracoesAquarioViewState extends State<ConfiguracoesAquarioView> {
  final AquarioDAO _aquarioDAO = AquarioDAO();

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
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: PrimaryButton(
                  backgroundColor: Colors.red,
                  onPressed: () => _deletarAquario(),
                  text: 'Deletar aquário',
                ),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GerenciadorParametroAquario(aquarioDTO: widget.aquarioDTO),
                  const Spacer(),
                  GerenciadorUsuariosAutorizados(aquarioDTO: widget.aquarioDTO),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deletarAquario() {
    try {
      showDialog(
        context: context,
        builder: (context) => const QuestionDialog(
            message:
                'Realmente deseja apagar esse aquário, tudo relacionado com ele será deletado.'),
      ).then((value) async {
        if (!value) {
          return;
        }

        await _aquarioDAO.deletarAquario(widget.aquarioDTO.id ?? 0);
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) =>
                const SuccessDialog(message: 'Aquário deletado com sucesso.'),
          ).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          });
        }
      });
    } on ApiErroDTO catch (exception, stacktrace) {
      showDialog(
        context: context,
        builder: (context) => FailDialog(message: exception.mensagem ?? ''),
      );
      debugPrint('$exception\n$stacktrace');
    }
  }
}
