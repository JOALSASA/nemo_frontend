class NovoUsuarioForm {
  String? nomeUsuario;
  String? email;
  String? senha;

  NovoUsuarioForm({this.nomeUsuario, this.email, this.senha});

  NovoUsuarioForm.fromJson(Map<String, dynamic> json) {
    nomeUsuario = json['nomeUsuario'];
    email = json['email'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomeUsuario'] = nomeUsuario;
    data['email'] = email;
    data['senha'] = senha;
    return data;
  }
}