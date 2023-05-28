import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/inputs/custom_form_field.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';

class BoasVindasView extends StatefulWidget {
  const BoasVindasView({Key? key}) : super(key: key);

  @override
  State<BoasVindasView> createState() => _BoasVindasViewState();
}

class _BoasVindasViewState extends State<BoasVindasView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  //TODO: Corrigir font da appbar -> Aplicar font Aleta
  //TODO: Avaliar uso de valores fixos e resposividade para mobile

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
                      _passwordController.clear();
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
                      _passwordController.clear();
                      setState(() {
                        _bodyCard = _buildLoginCard();
                      });
                    }),
                const SizedBox(width: 37),
                AppBarTextButton(
                    text: 'Registrar',
                    onPressed: () {
                      _passwordController.clear();
                      setState(() {
                        _bodyCard = _buildRegistroCard();
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

  Widget _buildLoginCard() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.sizeOf(context).width * 0.1576,
      ),
      constraints: const BoxConstraints(maxHeight: 615, maxWidth: 390),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: PaletaCores.azul1,
      ),
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Entrar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              const SizedBox(height: 40),
              CustomFormField(
                height: 49,
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                icon: 'assets/icons/arroba_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                height: 49,
                controller: _passwordController,
                hintText: 'Password',
                keyboardType: TextInputType.text,
                icon: 'assets/icons/senha_icon.png',
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                onPressed: () {},
                width: 153,
                height: 45,
                text: 'Entrar',
              ),
              const SizedBox(height: 30),
              const Text(
                'Ainda não possui uma conta?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                onPressed: () {
                  _passwordController.clear();
                  setState(() {
                    _bodyCard = _buildRegistroCard();
                  });
                },
                width: 124,
                height: 35,
                text: 'Registrar',
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
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

  Widget _buildRegistroCard() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.sizeOf(context).width * 0.1576,
      ),
      constraints: const BoxConstraints(maxHeight: 615, maxWidth: 390),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: PaletaCores.azul1,
      ),
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Registrar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              const SizedBox(height: 40),
              CustomFormField(
                height: 49,
                controller: _usernameController,
                hintText: 'Username',
                keyboardType: TextInputType.text,
                icon: 'assets/icons/user_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                height: 49,
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                icon: 'assets/icons/arroba_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                height: 49,
                controller: _passwordController,
                hintText: 'Password',
                keyboardType: TextInputType.text,
                icon: 'assets/icons/senha_icon.png',
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                onPressed: () {},
                width: 153,
                height: 45,
                text: 'Registrar',
              ),
              const SizedBox(height: 30),
              const Text(
                'Já possui uma conta?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                onPressed: () {
                  _passwordController.clear();
                  setState(() {
                    _bodyCard = _buildLoginCard();
                  });
                },
                width: 124,
                height: 35,
                text: 'Entrar',
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
