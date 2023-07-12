import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/custom/reusable_future_builder.dart';
import 'package:nemo_frontend/components/custom/sombra_default.dart';
import 'package:nemo_frontend/components/dialogs/fail_dialog.dart';
import 'package:nemo_frontend/components/dialogs/success_dialog.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/aquario_parametro_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/parametro/aquario_parametro_dto.dart';
import 'package:nemo_frontend/models/parametro/historico_dto.dart';
import 'package:nemo_frontend/utils/regex.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GraficoAquario extends StatefulWidget {
  const GraficoAquario({required this.aquarioParametroDTO, Key? key})
      : super(key: key);
  final AquarioParametroDTO aquarioParametroDTO;

  @override
  State<GraficoAquario> createState() => _GraficoAquarioState();
}

class _GraficoAquarioState extends State<GraficoAquario> {
  final AquarioParametroDAO aquarioParametroDAO = AquarioParametroDAO();
  Future<List<HistoricoDTO>>? futureHistoricos;

  late TooltipBehavior _tooltipBehavior;
  final _valorParametroController = TextEditingController();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    fetchHistoricos();
    super.initState();
  }

  void fetchHistoricos() {
    futureHistoricos = aquarioParametroDAO
        .listarHistoricoAquarioParametro(widget.aquarioParametroDTO.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: PaletaCores.cinza2,
            boxShadow: [SombraDefault()]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ReusableFutureBuilder(
              future: futureHistoricos!,
              builder: (context, snapshot) {
                List<HistoricoDTO> historicos = snapshot.data!;
                return SfCartesianChart(
                  title: ChartTitle(
                      text: '${widget.aquarioParametroDTO.parametroDto?.tipo}'),
                  legend: const Legend(isVisible: true),
                  primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm()),
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    LineSeries(
                      dataSource: historicos,
                      name: '${widget.aquarioParametroDTO.parametroDto?.tipo}',
                      xValueMapper: (datum, index) => historicos[index].hora,
                      yValueMapper: (datum, index) => historicos[index].valor,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      fetchHistoricos();
                    });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.refresh_rounded),
                        Text('Atualizar')
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  constraints:
                      const BoxConstraints(maxWidth: 180, maxHeight: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Valor para o parâmetro'),
                    controller: _valorParametroController,
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
                  ),
                ),
                PrimaryButton(
                    height: 30,
                    width: 95,
                    fontSize: 14,
                    onPressed: () => _adicionarValorAoParametro(),
                    text: 'inserir'),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _adicionarValorAoParametro() async {
    try {
      await aquarioParametroDAO.adicionarValorParametro(
          idAquarioParametro: widget.aquarioParametroDTO.id ?? 0,
          valor: _valorParametroController.text);
      _valorParametroController.clear();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) =>
          const SuccessDialog(message: 'Valor cadastrado com sucesso.'),
        ).then((value) {
          setState(() {
            fetchHistoricos();
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
