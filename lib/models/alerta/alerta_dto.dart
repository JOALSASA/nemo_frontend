class AlertaDTO{
  int? id;
  String? nome;
  int? min;
  int? max;
  String? estadoAlerta;
  String? nomeAquario;
  String? tipoParametro;


  AlertaDTO({this.id, this.nome, this.min, this.max, this.estadoAlerta,
      this.nomeAquario, this.tipoParametro});

  AlertaDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    min = json['min'];
    max = json['max'];
    estadoAlerta = json['estadoAlerta'];
    nomeAquario = json['nomeAquario'];
    tipoParametro = json['tipoParametro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['min'] = min;
    data['max'] = max;
    data['estadoAlerta'] = estadoAlerta;
    data['nomeAquario'] = nomeAquario;
    data['tipoParametro'] = tipoParametro;

    return data;
  }
}