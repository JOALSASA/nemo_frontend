import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/appbars/primary_app_bar.dart';

class ContaView extends StatefulWidget {
  const ContaView({Key? key}) : super(key: key);

  @override
  State<ContaView> createState() => _ContaViewState();
}

class _ContaViewState extends State<ContaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(telaConta: true, context: context),
      body: const Placeholder(),
    );
  }
}
