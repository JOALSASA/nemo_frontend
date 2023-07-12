import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/custom/reusable_future_builder.dart';
import 'package:nemo_frontend/components/custom/sombra_default.dart';
import 'package:nemo_frontend/components/dialogs/question_dialog.dart';
import 'package:nemo_frontend/components/dialogs/success_dialog.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/aquario_parametro_dao.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';
import 'package:nemo_frontend/models/parametro/aquario_parametro_dto.dart';
import 'package:nemo_frontend/models/parametro/parametro_form.dart';
import 'package:flutter/services.dart';
import 'package:nemo_frontend/utils/regex.dart';

class GerenciadorParametroAquario extends StatefulWidget {
  const GerenciadorParametroAquario({Key? key, required this.aquarioDTO})
      : super(key: key);

  final AquarioDTO aquarioDTO;

  @override
  State<GerenciadorParametroAquario> createState() =>
      _GerenciadorParametroAquarioState();
}

class _GerenciadorParametroAquarioState
    extends State<GerenciadorParametroAquario> {
  final AquarioParametroDAO aquarioParametroDAO = AquarioParametroDAO();
  Future<List<AquarioParametroDTO>>? futureList;

  @override
  void initState() {
    super.initState();
    futureList = fetchParametrosAquario();
  }

  Future<List<AquarioParametroDTO>> fetchParametrosAquario() {
    return aquarioParametroDAO
        .listarParametrosAquario(widget.aquarioDTO.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 580, minWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Parâmetros cadastrados',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF010D26),
                  height: 1,
                ),
              ),
              const Spacer(),
              /*IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/lapis_icon.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        'Editar',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),*/
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  dialogAdicionarParametro();
                },
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/cruz_icon.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        'Adicionar',
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
          ReusableFutureBuilder<AquarioParametroDTO>(
            future: futureList!,
            builder: (context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) =>
                    _buildParametroItem(snapshot.data![index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildParametroItem(AquarioParametroDTO aquarioParametroDTO) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black, width: 1),
        ),
        boxShadow: [SombraDefault()],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              '${aquarioParametroDTO.parametroDto?.tipo}',
              style: const TextStyle(
                fontSize: 20,
                color: PaletaCores.azul2,
              ),
            ),
            const Spacer(),
            _buildStatusParametro(aquarioParametroDTO),
            const SizedBox(width: 30),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => const QuestionDialog(
                      message:
                          'Tem certeza que deseja deletar esse parâmetro?'),
                ).then((value) async {
                  if (value == null || !value) {
                    return;
                  }
                  await aquarioParametroDAO.excluirParametro(
                      idAquario: aquarioParametroDTO.aquariosId ?? 0,
                      idAquarioParametro: aquarioParametroDTO.id ?? 0);
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) => const SuccessDialog(
                          message: 'Parâmetro deletado com sucesso.'),
                    );
                    setState(() {
                      futureList = fetchParametrosAquario();
                    });
                  }
                });
              },
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
      ),
    );
  }

  Widget _buildStatusParametro(AquarioParametroDTO aquarioParametroDTO) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${aquarioParametroDTO.parametroDto?.min}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const Text(
                'min',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${aquarioParametroDTO.parametroDto?.max}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const Text(
                'max',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void dialogAdicionarParametro() {
    var listaTipoParametros = TipoParametro.values
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e.name,
              style: const TextStyle(color: PaletaCores.azul3),
            ),
          ),
        )
        .toList();
    final form = GlobalKey<FormState>();
    String? valorParametro;

    TipoParametro? tipoParametroSelecionado;

    Dialog dialog = Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.30,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Container(
                decoration: const BoxDecoration(
                  color: PaletaCores.azul2,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: DropdownButtonFormField(
                  hint: const Text(
                    "Selecione um parâmetro",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 45, right: 10),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        textDirection: TextDirection.ltr,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  padding: const EdgeInsets.only(left: 14),
                  items: listaTipoParametros,
                  onChanged: (valor) {
                    if (valor != null) {
                      tipoParametroSelecionado = valor;
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration:
                    const InputDecoration(hintText: 'Valor para o parâmetro'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return Regex.numbersOnly.hasMatch(newValue.text)
                        ? newValue
                        : oldValue;
                  })
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um valor inicial';
                  }
                  return null;
                },
                onChanged: (value) => valorParametro = value,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(
                      onPressed: () async {
                        int index = TipoParametro.values
                            .indexOf(tipoParametroSelecionado!);

                        aquarioParametroDAO
                            .adicionarParametro(
                          parametroForm: ParametroForm(
                            idAquario: widget.aquarioDTO.id,
                            tipoParametro: index,
                            valor: int.tryParse(valorParametro ?? ''),
                          ),
                        )
                            .then((value) {
                          Navigator.of(context).pop();
                          setState(() {
                            futureList = fetchParametrosAquario();
                          });
                          showDialog(
                            context: context,
                            builder: (context) => const SuccessDialog(
                                message: 'Parâmetro cadastrado com sucesso!'),
                          );
                        });
                      },
                      text: 'Adicionar'),
                  const SizedBox(width: 10),
                  PrimaryButton(
                      onPressed: () => Navigator.pop(context),
                      text: 'Cancelar'),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}

enum TipoParametro {
  Ph,
  Temperatura,
  Oxigenio,
  Iluminacao,
  BombaDagua,
  FluxoAgua,
  Nitrato,
}
