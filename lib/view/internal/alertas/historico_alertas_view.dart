import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

import '../../../components/buttons/primary_button.dart';

class HistoricoAlertasView extends StatefulWidget {
  const HistoricoAlertasView({Key? key}) : super(key: key);

  @override
  State<HistoricoAlertasView> createState() => _HistoricoAlertasViewState();
}

class _HistoricoAlertasViewState extends State<HistoricoAlertasView> {
  /*
  * TODO
  *  pegar lista de aquários
  *   pegar todos os alertas estourados e por aquário
  *     trocar infos do Grid para o que vir na response
  * */
  var aquarios = ["Selecione o aquário", "aquario 1", "aquario 2", "aquario 3"];
  var listaAlertas = [
    "alerta 1",
    "alerta 1",
    "alerta 1",
    "alerta 1",
    "alerta 1",
    "alerta 1",
    "alerta 1",
    "alerta 1"
  ];

  late List<bool> itemSelections =
      List.generate(listaAlertas.length, (index) => false);
  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(telaAlertas: true, context: context),
      body: Container(
        margin: const EdgeInsets.only(top: 73),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dropdownAquario(aquarios),
                  switchPaginas(),
                  funcoesPaginasAlerta()
                ],
              ),
              GridView.builder(
                  padding:
                      const EdgeInsets.only(left: 176, right: 173, top: 88),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width ~/ 700,
                    crossAxisSpacing: 82,
                    mainAxisSpacing: 56,
                    childAspectRatio: 480 / 107,
                  ),
                  itemCount: listaAlertas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Checkbox(
                            // pega a lista e troca o valor do booleano de acordo com o indice do alerta
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
                              const Text(
                                'Nome do Alerta',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 21.9),
                              Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nome do Aquário',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Início: 21/05/2023 - 13:45:43",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Parâmetro:',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Término: 22/05/2023 - 13:45:43",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  /*
  * TODO
  *  pegar lista dos aquários no banco
  * */
  dropdownAquario(List<String> listaAquarios) {
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
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        padding: const EdgeInsets.only(left: 14),
        underline: const SizedBox(),
        items: aquarios.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (val) {},
      ),
    );
  }

  /*
  * TODO
  *  rota
  * */
  switchPaginas() {
    return Row(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("Meus Alertas")),
        Container(
          height: 58,
          width: 2,
          color: PaletaCores.azul2,
          margin: const EdgeInsets.symmetric(horizontal: 9.5),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Histórico")),
      ],
    );
  }

  /*
  * TODO
  *  realizar funcionalidade
  * */
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
}
