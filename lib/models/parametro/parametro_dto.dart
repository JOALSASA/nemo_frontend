class ParametroDTO {
  int? id;
  String? tipo;
  int? min;
  int? max;

  ParametroDTO({this.id, this.tipo, this.min, this.max});

  ParametroDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = tipo;
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}