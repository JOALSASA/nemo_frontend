import 'dart:convert';

import 'package:nemo_frontend/models/alerta/alerta_dto.dart';

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
}