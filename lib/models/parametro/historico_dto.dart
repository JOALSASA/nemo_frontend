import 'package:intl/intl.dart';
import 'package:nemo_frontend/models/usuario/usuario_dto.dart';

class HistoricoDTO {
  int? id;
  int? valor;
  DateTime? hora;
  int? aquarioParametroId;
  UsuarioDTO? usuarioDto;

  HistoricoDTO(
      {this.id,
      this.valor,
      this.hora,
      this.aquarioParametroId,
      this.usuarioDto});

  HistoricoDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    hora = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['hora']);
    aquarioParametroId = json['aquarioParametroId'];
    usuarioDto = json['usuarioDto'] != null
        ? UsuarioDTO.fromJson(json['usuarioDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['valor'] = valor;
    data['hora'] = DateFormat('yyyy-MM-ddTHH:mm:ss').format(hora!);
    data['aquarioParametroId'] = aquarioParametroId;
    if (usuarioDto != null) {
      data['usuarioDto'] = usuarioDto!.toJson();
    }
    return data;
  }
}
