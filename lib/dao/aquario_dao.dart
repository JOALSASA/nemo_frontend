import 'dart:convert';

import 'package:nemo_frontend/dao/base_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/aquario_dto.dart';

class AquarioDAO extends BaseDAO {
  // Implementação do singleton com construtores factorys do dart
  static final AquarioDAO _singleton = AquarioDAO._internal();
  final String _basePath = '/api/Aquario';

  factory AquarioDAO() {
    return _singleton;
  }

  AquarioDAO._internal();

  Future<List<AquarioDTO>> listarAquariosUsuario() async {
    var url = getCompleteUrl(path: '$_basePath/listar');
    try {
      var response = await get(url);
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      if (response.statusCode == 200) {
        return List<AquarioDTO>.from(jsonDecode(decode).map(
          (x) => AquarioDTO.fromJson(x),
        ));
      }

      return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
    } catch (e) {
      rethrow;
    }
  }
}
