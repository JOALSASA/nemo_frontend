import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/view/external/boas_vindas_view.dart';
import 'package:nemo_frontend/view/internal/alertas/meus_alertas_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nemo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PaletaCores.azul1),
        fontFamily: 'CreateRound',
        useMaterial3: true,
      ),
      home: const /*BoasVindasView()*/ MeusAlertasView(),
      routes: {'/boas-vindas': (context) => const BoasVindasView()},
      debugShowCheckedModeBanner: false,
    );
  }
}
