import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nemo_frontend/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredenciaisUsuario {
  static Usuario? _usuario;
  static const _usuarioKey = 'usuario_logado';

  /// Salva o usuário obtido através do token no SharedPreferences
  static Future<Usuario> salvarUsuario(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    _usuario = Usuario(
      id: decodedToken['id'],
      nome: decodedToken['nome'],
      email: decodedToken['email'],
      role: decodedToken['role'],
      token: token,
    );
    var instance = await SharedPreferences.getInstance();
    instance.setString(_usuarioKey, _usuario!.toJson().toString());
    return _usuario!;
  }

  /// Carrega o usuário
  static Future<Usuario?> carregarUsuario() async {
    var instance = await SharedPreferences.getInstance();
    var usuarioJson = instance.getString(_usuarioKey);
    if (usuarioJson == null) {
      return null;
    }

    _usuario = Usuario.fromJson(jsonDecode(usuarioJson));
    return _usuario;
  }

  static String getToken() {
    if (_usuario == null || _usuario!.token == null) {
      return '';
    }
    return _usuario!.token!;
  }

  static Future<void> clearStorage() async {
    _usuario = null;
    var instance = await SharedPreferences.getInstance();
    instance.clear();
  }
}
