import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nemo_frontend/dao/alerta_dao.dart';
import 'package:nemo_frontend/main.dart';
import 'package:nemo_frontend/models/alerta/novo_alerta_form.dart';

import '../../../components/buttons/primary_button.dart';
import '../../../components/utils/PaletaCores.dart';
import '../../../dao/aquario_dao.dart';
import '../../../dao/aquario_parametro_dao.dart';
import '../../../models/aquario/aquario_dto.dart';
import '../../../models/parametro/aquario_parametro_dto.dart';

class AddAlertaDialog extends StatefulWidget {
  AddAlertaDialog({Key? key}) : super(key: key);

  @override
  _AddAlertaDialogState createState() => _AddAlertaDialogState();
}

class _AddAlertaDialogState extends State<AddAlertaDialog> {
  Future<List<AquarioDTO>>? aquariosFuture;
  Future<List<AquarioParametroDTO>>? parametrosFuture;
  AquarioDTO? aquarioSelecionado;
  AquarioParametroDTO? parametroSelecionado;
  TextEditingController _valMinController = TextEditingController();
  TextEditingController _valMaxController = TextEditingController();
  TextEditingController _nomeAlertaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FToast fToast;

  _getAquarios() {
    aquariosFuture = AquarioDAO().listarAquariosUsuario();
  }

  _getParametrosAquario(int idAquario) {
    parametrosFuture = AquarioParametroDAO().listarParametrosAquario(idAquario);
  }

  @override
  void initState() {
    super.initState();
    _getAquarios();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AquarioDTO>>(
      future: aquariosFuture,
      builder: (context, snapshot) {
        return AlertDialog(
          title: const Text('Adicionar Alerta'),
          content: Container(
            height: 271,
            width: 575,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<List<AquarioDTO>>(
                        future: aquariosFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return Container(
                              height: 39,
                              width: 274,
                              decoration: const BoxDecoration(
                                color: PaletaCores.azul2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: DropdownButton(
                                hint: const Text(
                                  "Selecione o aquário",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 45),
                                  child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        textDirection: TextDirection.ltr,
                                        color: Colors.white,
                                      )),
                                ),
                                selectedItemBuilder: (BuildContext context) {
                                  return snapshot.data!
                                      .map<Widget>((AquarioDTO aquario) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 14),
                                      child: Text(
                                        aquario.nome!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                padding: const EdgeInsets.only(left: 14),
                                underline: const SizedBox(),
                                value: aquarioSelecionado,
                                items: snapshot.data!
                                    .map<DropdownMenuItem<AquarioDTO>>(
                                        (AquarioDTO aquario) {
                                  return DropdownMenuItem<AquarioDTO>(
                                    value: aquario,
                                    child: Text(aquario.nome!),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    aquarioSelecionado = newValue;
                                    _getParametrosAquario(
                                        aquarioSelecionado!.id!);
                                  });
                                },
                              ),
                            );
                          }
                        }),
                    FutureBuilder<List<AquarioParametroDTO>>(
                        future: parametrosFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.data == null) {
                            return const Text('Selecione um aquário primeiro', style: TextStyle(fontSize: 15),);
                          } else {
                            return Container(
                              height: 39,
                              //width: 300,
                              decoration: const BoxDecoration(
                                color: PaletaCores.azul2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: DropdownButton(
                                hint: const Text(
                                  "Selec. o Parametro",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 35, right: 10),
                                  child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        textDirection: TextDirection.ltr,
                                        color: Colors.white,
                                      )),
                                ),
                                selectedItemBuilder: (BuildContext context) {
                                  return snapshot.data!
                                      .map<Widget>((AquarioParametroDTO param) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 14),
                                      child: Text(
                                        param.parametroDto!.tipo!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                padding: const EdgeInsets.only(left: 14),
                                underline: const SizedBox(),
                                value: parametroSelecionado,
                                items: snapshot.data!
                                    .map<DropdownMenuItem<AquarioParametroDTO>>(
                                        (AquarioParametroDTO param) {
                                  return DropdownMenuItem<AquarioParametroDTO>(
                                    value: param,
                                    child: Text(
                                      param.parametroDto!.tipo!,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    parametroSelecionado = newValue;
                                  });
                                },
                              ),
                            );
                          }
                        }),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _nomeAlertaController,
                          decoration: const InputDecoration(
                            labelText: 'Digite o nome do alerta',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, digite o nome do alerta.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: _valMinController,
                          decoration: const InputDecoration(
                            labelText: 'min',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, digite o valor mínimo.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: _valMaxController,
                          decoration: const InputDecoration(
                            labelText: 'max',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, digite o valor máximo.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: PrimaryButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        NovoAlertaForm novoAlerta = NovoAlertaForm(
                            _nomeAlertaController.text,
                            int.tryParse(_valMinController.text),
                            int.tryParse(_valMaxController.text),
                            aquarioSelecionado!.id,
                            parametroSelecionado!.id);
                        if(await AlertaDAO().adicionarAlerta(novoAlerta)){
                          _mostrarAlerta(PaletaCores.verde1, Colors.white, 'Alerta adicionado com sucesso!');
                          sairDialog();
                        }else{
                          _mostrarAlerta(PaletaCores.vermelho1, Colors.white, 'Ocorreu  um erro ao adicionar o alerta.');
                        }
                      }
                    },
                    backgroundColor: PaletaCores.azul2,
                    text: 'Adicionar',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  sairDialog(){
    Navigator.pop(context);
  }

  _mostrarAlerta(Color color, Color textColor, String texto) {
    Widget toast = FittedBox(
      fit: BoxFit.contain,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: color,
        ),
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  texto,
                  style: TextStyle(fontSize: 30, color: textColor),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 3));
  }
}
