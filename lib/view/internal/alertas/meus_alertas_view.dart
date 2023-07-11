import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/alerta_dao.dart';
import 'package:nemo_frontend/dao/aquario_dao.dart';
import 'package:nemo_frontend/models/alerta/alerta_dto.dart';
import 'package:nemo_frontend/models/aquario/aquario_dto.dart';

import '../../../components/buttons/primary_button.dart';
import 'historico_alertas_view.dart';

class MeusAlertasView extends StatefulWidget {
  const MeusAlertasView({Key? key}) : super(key: key);

  @override
  State<MeusAlertasView> createState() => _MeusAlertasViewState();
}

class _MeusAlertasViewState extends State<MeusAlertasView> {
  late Future<List<AquarioDTO>> aquarios;
  Future<List<AlertaDTO>>? alertas;
  AquarioDTO? aquarioSelecionado;

  _getAquarios()  {
    aquarios = AquarioDAO().listarAquariosUsuario();
  }

  _getAllAlertas(){
    alertas = AlertaDAO().listarTodosOsAlertas();
    _getAlertas();
  }

  _getAlertasAquario(int idAquario){
    alertas = AlertaDAO().listarAlertasDoAquario(idAquario);
  }

  _getAlertas() async {
    List<AlertaDTO>? alertasList = await alertas;
    itemSelections = List.generate(alertasList!.length, (index) => false);
  }

  late List<bool> itemSelections;

  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    _getAquarios();
    _getAllAlertas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(telaAlertas: true, context: context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 73),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dropdownAquario(aquarios),
                  funcoesPaginasAlerta()
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: PrimaryButton(
                  onPressed: () {
                    showDialogAddAlerta();
                  },
                  backgroundColor: PaletaCores.azul2,
                  text: 'Adicionar Alerta',
                  fontSize: 16,
                ),
              ),
              FutureBuilder<List<AlertaDTO>>(
                  future: alertas,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else{
                      return GridView.builder(
                          padding:
                          const EdgeInsets.only(left: 176, right: 173),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width ~/ 700,
                            crossAxisSpacing: 82,
                            mainAxisSpacing: 56,
                            childAspectRatio: 480 / 107,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Checkbox(
                                    value: itemSelections[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        itemSelections[index] = value!;
                                        print(itemSelections[index]);
                                      });
                                    }),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(20)),
                                        color: PaletaCores.cinza2,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.25),
                                              offset: const Offset(4, 4),
                                              blurRadius: 5)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data![index].nome!,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(width: 21.9),
                                            const Text(
                                              'Estado:',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(width: 4.98),
                                            estadoAlerta(snapshot.data![index].estadoAlerta!),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            'Nome do Aquário: ${snapshot.data![index].nomeAquario!}',
                                            style: const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            'Parâmetro: ${snapshot.data![index].tipoParametro!}' ,
                                            style: const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  dropdownAquario(Future<List<AquarioDTO>> listaAquarios) {
    return FutureBuilder<List<AquarioDTO>>(
        future: listaAquarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Exibir um indicador de progresso enquanto a lista está sendo carregada
            return const CircularProgressIndicator();
          } else{
            return Container(
              height: 39,
              width: 274,
              decoration: const BoxDecoration(
                color: PaletaCores.azul2,
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  return snapshot.data!.map<Widget>((AquarioDTO aquario) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, left: 14),
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
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                padding: const EdgeInsets.only(left: 14),
                underline: const SizedBox(),
                value: aquarioSelecionado,
                items: snapshot.data!.map<DropdownMenuItem<AquarioDTO>>((AquarioDTO aquario) {
                  return DropdownMenuItem<AquarioDTO>(
                    value: aquario,
                    child: Text(aquario.nome!),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    aquarioSelecionado = newValue;
                    _getAlertasAquario(aquarioSelecionado!.id!);
                  });
                },
              ),
            );
          }
        }
    );
  }


  funcoesPaginasAlerta() {
    return Row(
      children: [
        PrimaryButton(
          onPressed: () {
            setState(() {
              itemSelections.fillRange(0, itemSelections.length, !selectAll);
              selectAll = !selectAll;
            });
          },
          backgroundColor: PaletaCores.azul2,
          text: 'Selecionar todos',
          fontSize: 16,
        ),
        const SizedBox(
          width: 11,
        ),
        PrimaryButton(
          onPressed: () {},
          backgroundColor: PaletaCores.azul2,
          text: 'Excluir',
          fontSize: 16,
        ),
      ],
    );
  }

  estadoAlerta(String estado) {
    if (estado == 'Verde') {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: const CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.verde1,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.amarelo1.withOpacity(0.20),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.vermelho1.withOpacity(0.20),
            ),
          ),
        ],
      );
    }
    if (estado == 'Amarelo') {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.verde1.withOpacity(0.20),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: const CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.amarelo1,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.vermelho1.withOpacity(0.20),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.verde1.withOpacity(0.20),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.amarelo1.withOpacity(0.20),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: const CircleAvatar(
              radius: 11,
              backgroundColor: PaletaCores.vermelho1,
            ),
          ),
        ],
      );
    }
  }

  showDialogAddAlerta(){
    return showDialog(
        context: context,
        builder: (_) => Dialog(
          elevation: 50,
          shadowColor:
          const Color(0xff13426A),
          surfaceTintColor:
          const Color(0xffE7E7E7),
          child: Container(
            height: 271,
            width: 575,
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text("Adicionar Alerta",
                        style: TextStyle(
                          fontSize: 24
                        ),
                      ),
                    ),
                    dropdownAquario(aquarios)
                  ],
                ),
                const SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Digite o nome do alerta"
                    ),
                  ),
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Digite o parâmetro"
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "min"
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "max"
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: PrimaryButton(
                    onPressed: () {
                      /*
                      * TODO
                      *  adicionar alerta
                      * */
                      Navigator.pop(context);
                    },
                    backgroundColor: PaletaCores.azul2,
                    text: 'Adicionar',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
