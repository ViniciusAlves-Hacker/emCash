class CadastroFuncModel {
  String? id;
  String? dataHota;

  CadastroFuncModel({this.id, this.dataHota});

  CadastroFuncModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataHota = json['data_hota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_hota'] = this.dataHota;
    return data;
  }
}