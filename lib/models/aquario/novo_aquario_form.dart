class NovoAquarioForm {
  String? nome;
  int? largura;
  int? altura;
  int? comprimento;

  NovoAquarioForm({this.nome, this.largura, this.altura, this.comprimento});

  NovoAquarioForm.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    largura = json['largura'];
    altura = json['altura'];
    comprimento = json['comprimento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['largura'] = largura;
    data['altura'] = altura;
    data['comprimento'] = comprimento;
    return data;
  }
}