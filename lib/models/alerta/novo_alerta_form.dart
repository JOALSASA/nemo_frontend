class NovoAlertaForm {
  String? nome;
  int? min;
  int? max;
  int? aquarioId;
  int? aquarioParametroId;

  NovoAlertaForm.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    min = json['min'];
    max = json['max'];
    aquarioId = json['aquarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['min'] = min;
    data['max'] = max;
    data['aquarioId'] = aquarioId;
    data['aquarioParametroId'] = aquarioParametroId;

    return data;
  }

  NovoAlertaForm(
      this.nome, this.min, this.max, this.aquarioId, this.aquarioParametroId);
}