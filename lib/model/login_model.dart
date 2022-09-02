class LoginModel {
  String? accessToken;
  String? dataHota;

  LoginModel({this.accessToken, this.dataHota});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    dataHota = json['data_hota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['data_hota'] = this.dataHota;
    return data;
  }
}