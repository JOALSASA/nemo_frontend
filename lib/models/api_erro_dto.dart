class ApiErroDTO {
  String? mensagem;
  int? status;

  ApiErroDTO({this.mensagem, this.status});

  ApiErroDTO.fromJson(Map<String, dynamic> json) {
    mensagem = json['mensagem'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mensagem'] = mensagem;
    data['status'] = status;
    return data;
  }
}