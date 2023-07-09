import 'package:nemo_frontend/models/parametro/parametro_dto.dart';

class AquarioParametroDTO {
  int? id;
  int? aquariosId;
  int? parametrosId;
  ParametroDTO? parametroDto;
  int? valor;

  AquarioParametroDTO(
      {this.id,
      this.aquariosId,
      this.parametrosId,
      this.parametroDto,
      this.valor});

  AquarioParametroDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aquariosId = json['aquariosId'];
    parametrosId = json['parametrosId'];
    parametroDto = json['parametroDto'] != null
        ? ParametroDTO.fromJson(json['parametroDto'])
        : null;
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aquariosId'] = aquariosId;
    data['parametrosId'] = parametrosId;
    if (parametroDto != null) {
      data['parametroDto'] = parametroDto!.toJson();
    }
    data['valor'] = valor;
    return data;
  }
}
