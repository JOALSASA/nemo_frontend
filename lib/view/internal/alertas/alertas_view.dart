import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';

class AlertasView extends StatefulWidget {
  const AlertasView({Key? key}) : super(key: key);

  @override
  State<AlertasView> createState() => _AlertasViewState();
}

class _AlertasViewState extends State<AlertasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(telaAlertas: true, context: context),
      body: const Placeholder(),
    );
  }
}
