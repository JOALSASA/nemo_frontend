import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:nemo_frontend/main.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';
import 'package:nemo_frontend/utils/credenciais_usuario.dart';

abstract class BaseDAO {
  // TODO: Tratar o carregamento de diferentes ambientes
  String apiDomain = '192.168.0.111:8080';
  var logger = Logger();

  @protected
  Uri getCompleteUrl(
      {required String path, Map<String, dynamic>? queryParameters}) {
    return Uri.http(apiDomain, path, queryParameters);
  }

  Map<String, String>? _addAuthorizationHeader(Map<String, String>? headers) {
    if (headers == null) {
      return {'Authorization': CredenciaisUsuario.getToken()};
    }
    headers.putIfAbsent('Authorization', () => CredenciaisUsuario.getToken());
    return headers;
  }

  @protected
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    try {
      headers = _addAuthorizationHeader(headers);

      logger.d(
          'GET REQUEST: url: ${url.toString()}, headers: ${headers.toString()}');
      var response = await http.get(url, headers: headers);
      log('GET RESPONSE: status: ${response.statusCode} url: ${url.toString()}, body: ${headers.toString()}, body: ${response.body}');

      if (response.statusCode == 401) {
        await CredenciaisUsuario.clearStorage();
        navigatorKey.currentState!.pushReplacementNamed('/boas-vindas');
      }

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response;
      }
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);
      var decodedBody = jsonDecode(decode);

      return Future.error(ApiErroDTO.fromJson(decodedBody));
    } on ClientException catch (e) {
      logger.d('ClientException: ${e.message}');
      return Future.error(ApiErroDTO(mensagem: e.message));
    } on SocketException catch (e) {
      logger.d('SocketException: ${e.message}');
      return Future.error(
        ApiErroDTO(mensagem: 'Não foi possível se conectar com o servidor'),
      );
    } on FormatException catch (e) {
      logger.d('FormatException -> source: ${e.source} Message: ${e.message}');
      return Future.error(ApiErroDTO(
          mensagem: 'Erro durante a leitura dos dados trazidos do servidor'));
    } on HandshakeException catch (e) {
      logger.d(
          'HandshakeException -> osError: ${e.osError} Message: ${e.message}');
      return Future.error(ApiErroDTO(
          mensagem: 'Erro durante a leitura dos dados trazidos do servidor'));
    }
  }

  @protected
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      headers = _addAuthorizationHeader(headers);

      logger.d(
          'POST REQUEST: url: ${url.toString()}, headers: ${headers.toString()}, body: $body');
      var response = await http.post(url,
          headers: headers, body: body, encoding: encoding);
      logger.d(
          'POST RESPONSE: status: ${response.statusCode} url: ${url.toString()}, headers: ${headers.toString()}, body: ${response.body}');

      if (response.statusCode == 401) {
        await CredenciaisUsuario.clearStorage();
        navigatorKey.currentState!.pushReplacementNamed('/boas-vindas');
      }

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response;
      }
      var bodyBytes = response.bodyBytes;
      var decode = utf8.decode(bodyBytes);
      var decodedBody = jsonDecode(decode);

      return Future.error(ApiErroDTO.fromJson(decodedBody));
    } on ClientException catch (e) {
      logger.d('ClientException: ${e.message}');
      return Future.error(ApiErroDTO(
          mensagem:
              'Não foi possível concluir a operação por conta de um erro interno.'));
    } on SocketException catch (e) {
      logger.d('SocketException: ${e.message}');
      return Future.error(
        ApiErroDTO(mensagem: 'Não foi possível se conectar com o servidor.'),
      );
    } on FormatException catch (e) {
      logger.d('FormatException -> source: ${e.source} Message: ${e.message}');
      return Future.error(
        ApiErroDTO(
            mensagem: 'Erro durante a leitura dos dados trazidos do servidor.'),
      );
    } on HandshakeException catch (e) {
      logger.d(
          'HandshakeException -> osError: ${e.osError} Message: ${e.message}');
      return Future.error(ApiErroDTO(
          mensagem: 'Erro durante a leitura dos dados trazidos do servidor'));
    }
  }
}
