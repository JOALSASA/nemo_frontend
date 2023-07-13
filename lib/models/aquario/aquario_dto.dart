import 'package:nemo_frontend/models/usuario/usuario_dto.dart';

class AquarioDTO {
  int? id;
  String? nome;
  int? largura;
  int? altura;
  int? comprimento;
  UsuarioDTO? dono;

  AquarioDTO(
      {this.id,
      this.nome,
      this.largura,
      this.altura,
      this.comprimento,
      this.dono});

  AquarioDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    largura = json['largura'];
    altura = json['altura'];
    comprimento = json['comprimento'];
    dono = json['dono'] != null ? UsuarioDTO.fromJson(json['dono']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['largura'] = largura;
    data['altura'] = altura;
    data['comprimento'] = comprimento;
    if (dono != null) {
      data['dono'] = dono!.toJson();
    }
    return data;
  }
}
