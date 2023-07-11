class ParametroForm {
  int? idAquario;
  int? tipoParametro;
  int? valor;

  ParametroForm({this.idAquario, this.tipoParametro, this.valor});

  ParametroForm.fromJson(Map<String, dynamic> json) {
    idAquario = json['idAquario'];
    tipoParametro = json['tipoParametro'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idAquario'] = idAquario;
    data['tipoParametro'] = tipoParametro;
    data['valor'] = valor;
    return data;
  }
}