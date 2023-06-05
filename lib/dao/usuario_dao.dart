import 'dart:convert';
import 'package:nemo_frontend/dao/base_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/login_form.dart';
import 'package:nemo_frontend/models/novo_usuario_form.dart';
import 'package:nemo_frontend/models/usuario_dto.dart';

class UsuarioDAO extends BaseDAO {
  // Implementação do singleton com construtores factorys do dart
  static final UsuarioDAO _singleton = UsuarioDAO._internal();
  final String _basePath = '/api/Usuario';

  factory UsuarioDAO() {
    return _singleton;
  }

  UsuarioDAO._internal();

  Future<String> autenticarUsuario({required LoginForm loginForm}) async {
    var url = getCompleteUrl(path: '$_basePath/autenticar');
    try {
      var response = await post(url,
          body: jsonEncode(loginForm.toJson()),
          headers: {
            'Content-type': 'application/json',
          },
          ignoreUnauthorized: true);
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      return 'Bearer $decode';
    } catch (e) {
      rethrow;
    }
  }

  Future<UsuarioDTO> registrarNovoUsuario(
      {required NovoUsuarioForm novoUsuarioForm}) async {
    var url = getCompleteUrl(path: _basePath);
    try {
      var response =
          await post(url, body: jsonEncode(novoUsuarioForm.toJson()), headers: {
        'Content-type': 'application/json',
      });
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      if (response.statusCode == 201) {
        return UsuarioDTO.fromJson(jsonDecode(decode));
      }

      return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
    } catch (e) {
      rethrow;
    }
  }
}
