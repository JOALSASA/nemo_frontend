import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/inputs/custom_form_field.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/usuario_dao.dart';
import 'package:nemo_frontend/models/login_form.dart';
import 'package:nemo_frontend/models/usuario_dto.dart';
import 'package:nemo_frontend/utils/local_storage.dart';
import 'package:nemo_frontend/view/internal/home_view.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);


  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final UsuarioDAO _usuarioDAO = UsuarioDAO();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                validator: _emailValidator,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                icon: 'assets/icons/arroba_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                height: 49,
                controller: _passwordController,
                validator: _passwordValidator,
                hintText: 'Password',
                keyboardType: TextInputType.text,
                icon: 'assets/icons/senha_icon.png',
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                onPressed: () {
                  autenticar();
                },
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
            builder: (context) => HomeView(usuario: usuario),
          ),
        );
      } else {
        //TODO: Mensagem de falha na autenticação
        LocalStorage.clearStorage();
      }
    } catch (e) {
      //TODO: Dialogo para mostrar os erros
      print(e.toString());
    }
  }

  // TODO: Validar o email do usuário
  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
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
}
