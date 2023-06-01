import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/buttons/primary_button.dart';
import 'package:nemo_frontend/components/inputs/custom_form_field.dart';
import 'package:nemo_frontend/components/utils/PaletaCores.dart';
import 'package:nemo_frontend/dao/usuario_dao.dart';
import 'package:nemo_frontend/models/novo_usuario_form.dart';

class RegistroCard extends StatefulWidget {
  const RegistroCard({Key? key}) : super(key: key);


  @override
  State<RegistroCard> createState() => _RegistroCardState();
}

class _RegistroCardState extends State<RegistroCard> {
  final UsuarioDAO _usuarioDAO = UsuarioDAO();
  final _usernameController = TextEditingController();
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
                'Registrar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              const SizedBox(height: 40),
              CustomFormField(
                height: 49,
                controller: _usernameController,
                hintText: 'Username',
                validator: _usernameValidator,
                keyboardType: TextInputType.text,
                icon: 'assets/icons/user_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                height: 49,
                controller: _emailController,
                hintText: 'Email',
                validator: _emailValidator,
                keyboardType: TextInputType.emailAddress,
                icon: 'assets/icons/arroba_icon.png',
              ),
              const SizedBox(height: 20),
              CustomFormField(
                height: 49,
                controller: _passwordController,
                hintText: 'Password',
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
                onPressed: () {
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

  String? _usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
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
