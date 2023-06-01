import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/usuario_dao.dart';
import 'package:nemo_frontend/view/external/login_card.dart';
import 'package:nemo_frontend/view/external/registro_card.dart';

class BoasVindasView extends StatefulWidget {
  const BoasVindasView({Key? key}) : super(key: key);

  @override
  State<BoasVindasView> createState() => _BoasVindasViewState();
}

class _BoasVindasViewState extends State<BoasVindasView> {
  final UsuarioDAO _usuarioDAO = UsuarioDAO();

  //TODO: Corrigir font da appbar -> Aplicar font Aleta
  //TODO: remover(reduzir) o uso de valores fixos e avaliar questão de resposividade para mobile
  //TODO: Carregar as informações do usuário logado

  Widget? _bodyCard;

  @override
  void initState() {
    super.initState();
    _bodyCard = _buildBoasVindasCard();
  }

  @override
  Widget build(BuildContext context) {
    final larguraAtual = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Container(
          margin: const EdgeInsets.only(left: 85),
          child: const Text(
            'NEMO',
            style: TextStyle(color: PaletaCores.azul2, fontSize: 40),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: larguraAtual * 0.0625),
            child: Row(
              children: [
                AppBarTextButton(
                    text: 'Home',
                    onPressed: () {
                      setState(() {
                        _bodyCard = _buildBoasVindasCard();
                      });
                    }),
                const SizedBox(width: 37),
                AppBarTextButton(text: 'Sobre', onPressed: () {}),
                const SizedBox(width: 37),
                AppBarTextButton(
                    text: 'Entrar',
                    onPressed: () {
                      setState(() {
                        _bodyCard = const LoginCard();
                      });
                    }),
                const SizedBox(width: 37),
                AppBarTextButton(
                    text: 'Registrar',
                    onPressed: () {
                      setState(() {
                        _bodyCard = const RegistroCard();
                      });
                    }),
              ],
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.29375),
            decoration: BoxDecoration(
                image: DecorationImage(
              image:
                  Image.asset('assets/images/fish_background_image.png').image,
              fit: BoxFit.fill,
            )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: _bodyCard,
          )
        ],
      ),
    );
  }

  Widget _buildBoasVindasCard() {
    return Container(
      width: 576,
      margin: const EdgeInsets.only(left: 75),
      decoration: const BoxDecoration(
        color: PaletaCores.azul1,
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 28, right: 50, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                'Aquários saudáveis, peixes felizes.',
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
            ),
            Flexible(
              child: Text(
                'Gerencie seu aquário com facilidade',
                style: TextStyle(color: PaletaCores.azul4, fontSize: 48),
              ),
            ),
            Flexible(
              child: Text(
                'Gerencie seus aquários e registre seus equipamentos. Simplifique o cuidado dos seus aquários, mantendo todas as informações essenciais em um só lugar.',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
