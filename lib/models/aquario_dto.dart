class AquarioDTO {
  int? id;
  String? nome;
  int? largura;
  int? altura;
  int? comprimento;

  AquarioDTO({this.id, this.nome, this.largura, this.altura, this.comprimento});

  AquarioDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    largura = json['largura'];
    altura = json['altura'];
    comprimento = json['comprimento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['largura'] = largura;
    data['altura'] = altura;
    data['comprimento'] = comprimento;
    return data;
  }
}