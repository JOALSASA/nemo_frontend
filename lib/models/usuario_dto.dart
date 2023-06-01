class UsuarioDTO {
  int? id;
  String? nome;
  String? email;
  String? role;
  String? token;

  UsuarioDTO({this.id, this.nome, this.email, this.role, this.token});

  UsuarioDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['email'] = email;
    data['role'] = role;
    data['token'] = token;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, email: $email, role: $role, token: $token}';
  }
}