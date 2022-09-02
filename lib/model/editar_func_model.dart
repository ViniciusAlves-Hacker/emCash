class EditarFuncModel {
  String? dataHota;

  EditarFuncModel({this.dataHota});

  EditarFuncModel.fromJson(Map<String, dynamic> json) {
    dataHota = json['data_hota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_hota'] = this.dataHota;
    return data;
  }
}