import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/inputs/custom_form_field.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/components/utils/snack_bar_utils.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/models/aquario/novo_aquario_form.dart';

class CadastroAquarioDialog extends StatefulWidget {
  const CadastroAquarioDialog({Key? key}) : super(key: key);

  @override
  State<CadastroAquarioDialog> createState() => _CadastroAquarioDialogState();
}

class _CadastroAquarioDialogState extends State<CadastroAquarioDialog> {
  final AquarioDAO aquarioDAO = AquarioDAO();

  final _form = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _comprimentoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.30),
      backgroundColor: PaletaCores.azul1,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 20),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Cadastro de novo aquário',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 15),
              CustomFormField(
                  controller: _nomeController,
                  hintText: 'Nome Aquário',
                  keyboardType: TextInputType.text,
                  validator: validator),
              const SizedBox(height: 10),
              CustomFormField(
                  controller: _larguraController,
                  hintText: 'Largura (em cm)',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: validator),
              const SizedBox(height: 10),
              CustomFormField(
                  controller: _alturaController,
                  hintText: 'Altura (em cm)',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: validator),
              const SizedBox(height: 10),
              CustomFormField(
                  controller: _comprimentoController,
                  hintText: 'Comprimento (em cm)',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: validator),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  PrimaryButton(
                    onPressed: () => cadastrarAquario(),
                    fontSize: 16,
                    text: 'Cadastrar',
                  ),
                  const Spacer(),
                  PrimaryButton(
                    onPressed: () => Navigator.pop(context, false),
                    fontSize: 16,
                    text: 'Cancelar',
                  ),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void cadastrarAquario() async {
    if (!_form.currentState!.validate()) {
      return;
    }

    NovoAquarioForm novoAquarioForm = NovoAquarioForm(
      nome: _nomeController.text,
      largura: int.tryParse(_larguraController.text),
      comprimento: int.tryParse(_alturaController.text),
      altura: int.tryParse(_comprimentoController.text),
    );

    try {
      AquarioDTO novoAquario =
          await aquarioDAO.cadastrarAquario(novoAquarioForm);

      if (context.mounted) {
        Navigator.pop(context, true);
      }
    } on ApiErroDTO catch (e) {
      SnackBarUtils.showCustomSnackBar(context, '${e.mensagem}');
      Navigator.pop(context, false);
    } catch (e) {
      SnackBarUtils.showApiInternalErrorSnackBar(context);
      Navigator.pop(context, false);
    }
  }

  String? validator(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
