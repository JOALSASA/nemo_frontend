import 'dart:convert';
import 'package:nemo_frontend/dao/base_dao.dart';
import 'package:nemo_frontend/models/login_form.dart';

class UsuarioDAO extends BaseDAO {
  // Implementação do singleton com construtores factorys do dart
  static final UsuarioDAO _singleton = UsuarioDAO._internal();

  factory UsuarioDAO() {
    return _singleton;
  }
  UsuarioDAO._internal();

  Future<String> autenticarUsuario(
      {required LoginForm loginForm}) async {
    var url = getCompleteUrl(path: '/api/Usuario/autenticar');
    try {
      var response = await post(url, body: jsonEncode(loginForm.toJson()), headers: {
        'Content-type': 'application/json',
      });
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      return 'Bearer $decode';
    } catch(e) {
      rethrow;
    }
  }
}