import 'dart:convert';

import 'package:nemo_frontend/models/alerta/alerta_dto.dart';

import '../models/alerta/novo_alerta_form.dart';
import '../models/api_erro_dto.dart';
import 'base_dao.dart';

class AlertaDAO extends BaseDAO {
  static final AlertaDAO _singleton = AlertaDAO._internal();
  final String _basePath = '/api/Alerta';

  factory AlertaDAO() {
    return _singleton;
  }

  AlertaDAO._internal();

  Future<List<AlertaDTO>> listarAlertasDoAquario(int idAquario) async{
    var url = getCompleteUrl(path: '$_basePath/ConsultarAlertas/$idAquario');

    var response = await get(url);
    var bodyBytes = response.bodyBytes;
    var decode = utf8.decode(bodyBytes);

    if (response.statusCode == 200) {
      return List<AlertaDTO>.from(jsonDecode(decode).map(
            (x) => AlertaDTO.fromJson(x),
      ));
    }

    return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
  }

  Future<List<AlertaDTO>> listarTodosOsAlertas() async{
    var url = getCompleteUrl(path: '$_basePath/ConsultarAlertas');

    var response = await get(url);
    var bodyBytes = response.bodyBytes;
    var decode = utf8.decode(bodyBytes);

    if (response.statusCode == 200) {
      return List<AlertaDTO>.from(jsonDecode(decode).map(
            (x) => AlertaDTO.fromJson(x),
      ));
    }
    return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
  }

  Future<bool> adicionarAlerta(NovoAlertaForm novoAlertaForm) async{
    var url = getCompleteUrl(path: '$_basePath/AdicionarAlerta');
    try {
      var response = await post(url, body: jsonEncode(novoAlertaForm.toJson()), headers: {'Content-type': 'application/json',});
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);

      if (response.statusCode == 200) {
        return true;
      }

      return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> excluirAlerta(List<int> idAlertas) async{
    String parametros = 'idAlertas=${idAlertas.join('&idAlertas=')}';

    var url = Uri.parse('http://10.0.0.104:8080$_basePath/ExcluirAlerta').replace(query: parametros);

    var response = await delete(url);
    var bodyBytes = response.bodyBytes;
    var decode = utf8.decode(bodyBytes);

    if (response.statusCode == 204) {
      return true;
    }

    return Future.error(ApiErroDTO.fromJson(jsonDecode(decode)));
  }
}