import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/app_bar_text_button.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/inputs/custom_form_field.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/components/utils/snack_bar_utils.dart';
import 'package:nemo_frontend/dao/usuario_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/usuario/login_form.dart';
import 'package:nemo_frontend/models/usuario/novo_usuario_form.dart';
import 'package:nemo_frontend/models/usuario/usuario_dto.dart';
import 'package:nemo_frontend/utils/local_storage.dart';
import 'package:nemo_frontend/view/internal/home_view.dart';

class BoasVindasView extends StatefulWidget {
  const BoasVindasView({Key? key}) : super(key: key);

  @override
  State<BoasVindasView> createState() => _BoasVindasViewState();
}

class _BoasVindasViewState extends State<BoasVindasView> {
  final UsuarioDAO _usuarioDAO = UsuarioDAO();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  //TODO: remover(reduzir) o uso de valores fixos e avaliar questão de resposividade para mobile
  //TODO: Carregar as informações do usuário logado

  Widget? _bodyCard;

  //TODO: desabilitar botão de registro e login após o primeiro click e habilitar novamente quando a operação estiver terminado
  bool _disableActionBtn = false;

  @override
  void initState() {
    super.initState();
    _bodyCard = _buildBoasVindasCard();
    verificarUsuarioAutenticado();
  }

  void verificarUsuarioAutenticado() async {
    UsuarioDTO? usuarioDTO = await LocalStorage.carregarUsuario();
    if (usuarioDTO == null) {
      return;
    }

    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }
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
                        _bodyCard = _buildLoginCard();
                      });
                    }),
                const SizedBox(width: 37),
                AppBarTextButton(
                    text: 'Registrar',
                    onPressed: () {
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
                image: Image.asset('assets/images/fish_background_image.png')
                    .image,
                fit: BoxFit.fill,
              ),
            ),
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
                controller: _emailController,
                validator: _emailValidator,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                icon: 'assets/icons/arroba_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: _passwordController,
                validator: _passwordValidator,
                hintText: 'Password',
                isPasswordField: true,
                keyboardType: TextInputType.text,
                icon: 'assets/icons/senha_icon.png',
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                onPressed: () => autenticar(),
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
                onPressed: () => setState(() {
                  _bodyCard = _buildRegistroCard();
                }),
                width: 124,
                height: 35,
                text: 'Registrar',
                fontSize: 18,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void autenticar() async {
    if (!_form.currentState!.validate()) {
      return;
    }

    try {
      String token = await _usuarioDAO.autenticarUsuario(
          loginForm: LoginForm(
        email: _emailController.text,
        senha: _passwordController.text,
      ));

      UsuarioDTO usuario = await LocalStorage.salvarUsuario(token);

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      } else {
        //TODO: Mensagem de falha na autenticação
        LocalStorage.clearStorage();
      }
    } on ApiErroDTO catch (e) {
      SnackBarUtils.showCustomSnackBar(context, e.mensagem ?? '');
    } catch (e) {
      SnackBarUtils.showCustomSnackBar(context,
          'Ops, Houve um erro interno ao tentar realizar a autenticação.');
    }
  }

  // TODO: Validar o email do usuário
  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  // TODO: Escolher os padrões para avaliar a senha
  String? _passwordValidator(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
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
                controller: _usernameController,
                hintText: 'Username',
                validator: _usernameValidator,
                keyboardType: TextInputType.text,
                icon: 'assets/icons/user_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: _emailController,
                hintText: 'Email',
                validator: _emailValidator,
                keyboardType: TextInputType.emailAddress,
                icon: 'assets/icons/arroba_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: _passwordController,
                hintText: 'Password',
                isPasswordField: true,
                validator: _passwordValidator,
                keyboardType: TextInputType.text,
                icon: 'assets/icons/senha_icon.png',
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                onPressed: () {
                  _usuarioDAO.registrarNovoUsuario(
                    novoUsuarioForm: NovoUsuarioForm(
                      nomeUsuario: _usernameController.text,
                      email: _emailController.text,
                      senha: _passwordController.text,
                    ),
                  );
                },
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
                onPressed: () => setState(() {
                  _bodyCard = _buildLoginCard();
                }),
                width: 124,
                height: 35,
                fontSize: 18,
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
