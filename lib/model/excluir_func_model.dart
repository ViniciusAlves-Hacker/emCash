class ExcluirFuncModel {
  String? dataHota;

  ExcluirFuncModel({this.dataHota});

  ExcluirFuncModel.fromJson(Map<String, dynamic> json) {
    dataHota = json['data_hota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_hota'] = this.dataHota;
    return data;
  }
}