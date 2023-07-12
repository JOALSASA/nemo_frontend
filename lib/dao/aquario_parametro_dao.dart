import 'dart:convert';

import 'package:nemo_frontend/dao/base_dao.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/models/parametro/aquario_parametro_dto.dart';
import 'package:nemo_frontend/models/parametro/historico_dto.dart';
import 'package:nemo_frontend/models/parametro/parametro_form.dart';

class AquarioParametroDAO extends BaseDAO {
  static final AquarioParametroDAO _singleton = AquarioParametroDAO._internal();
  final String _basePath = '/api/aquario';

  factory AquarioParametroDAO() {
    return _singleton;
  }

  AquarioParametroDAO._internal();

  Future<List<AquarioParametroDTO>> listarParametrosAquario(
      int idAquario) async {
    var url = getCompleteUrl(path: '$_basePath/$idAquario/parametro/todos');

    var response = await get(url);
    var bodyBytes = response.bodyBytes;
    var decode = utf8.decode(bodyBytes);

    if (response.statusCode == 200) {
      return List<AquarioParametroDTO>.from(jsonDecode(decode).map(
        (x) => AquarioParametroDTO.fromJson(x),
      ));
    }

    return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
  }

  Future adicionarParametro({required ParametroForm parametroForm}) async {
    var url = getCompleteUrl(path: '/api/aquario-parametro');
    try {
      var response =
          await post(url, body: jsonEncode(parametroForm.toJson()), headers: {
        'Content-type': 'application/json',
      });
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      if (response.statusCode == 200) {
        return;
      }

      return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
    } catch (e) {
      rethrow;
    }
  }

  Future excluirParametro(
      {required int idAquario, required int idAquarioParametro}) async {
    var url = getCompleteUrl(
        path: '$_basePath/$idAquario/parametro/$idAquarioParametro');
    var response = await delete(url);
    var bodyBytes = response.bodyBytes;
    var decode = utf8.decode(bodyBytes);

    if (response.statusCode == 204) {
      return;
    }

    return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
  }

  Future<List<HistoricoDTO>> listarHistoricoAquarioParametro(
      int idAquarioParametro) async {
    var url = getCompleteUrl(
        path: 'api/aquario-parametro/$idAquarioParametro/historico');

    var response = await get(url);
    var bodyBytes = response.bodyBytes;
    var decode = utf8.decode(bodyBytes);

    if (response.statusCode == 200) {
      return List<HistoricoDTO>.from(jsonDecode(decode).map(
        (x) => HistoricoDTO.fromJson(x),
      ));
    }

    return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
  }

  Future adicionarValorParametro(
      {required int idAquarioParametro, required String valor}) async {
    var url = getCompleteUrl(
        path: '/api/aquario-parametro/$idAquarioParametro',
        queryParameters: {
          'valor': valor,
        });

    try {
      var response = await put(url, body: null);
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      if (response.statusCode == 204) {
        return;
      }

      return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
    } catch (e) {
      rethrow;
    }
  }
}
