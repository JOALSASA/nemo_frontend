import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class GerenciadorUsuariosAutorizados extends StatefulWidget {
  const GerenciadorUsuariosAutorizados({Key? key}) : super(key: key);

  @override
  State<GerenciadorUsuariosAutorizados> createState() =>
      _GerenciadorUsuariosAutorizadosState();
}

class _GerenciadorUsuariosAutorizadosState
    extends State<GerenciadorUsuariosAutorizados> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 580, minWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Usuários autorizados',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.50),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    usuariosAutorizadosItem('João Felipe'),
                    usuariosAutorizadosItem('João Junior'),
                    usuariosAutorizadosItem('João Carlos'),
                    usuariosAutorizadosItem('João Felipe'),
                    usuariosAutorizadosItem('João Junior'),
                    usuariosAutorizadosItem('João Carlos'),
                  ],
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  onPressed: () {},
                  backgroundColor: PaletaCores.azul2,
                  text: 'Adicionar usuário',
                  fontSize: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget usuariosAutorizadosItem(String nome) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            nome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF022859),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () {},
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
    );
  }
}
