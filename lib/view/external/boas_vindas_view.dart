import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';

class BoasVindasView extends StatefulWidget {
  const BoasVindasView({Key? key}) : super(key: key);

  @override
  State<BoasVindasView> createState() => _BoasVindasViewState();
}

class _BoasVindasViewState extends State<BoasVindasView> {
  @override
  Widget build(BuildContext context) {
    final larguraAtual = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
         Padding(
           padding: EdgeInsets.only(right:  larguraAtual * 0.0625),
           child: Row(
             children: [
               AppBarTextButton(text: 'Home', onPressed: () {}),
               AppBarTextButton(text: 'Sobre', onPressed: () {}),
               AppBarTextButton(text: 'Entrar', onPressed: () {}),
               AppBarTextButton(text: 'Registrar', onPressed: () {}),
             ],
           ),
         )
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.29375),
            decoration: BoxDecoration(
                image: DecorationImage(
              image:
                  Image.asset('assets/images/fish_background_image.png').image,
              fit: BoxFit.fill,
            )),
          )
        ],
      ),
    );
  }
}
