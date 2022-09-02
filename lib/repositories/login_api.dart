import 'dart:convert';
import 'package:em_cash/services/prefs_login.dart';
import 'package:http/http.dart' as http;
import 'package:em_cash/model/login_model.dart';

class LoginApi {
  login(String login, String senha) async {
    LoginModel loginModel;

    Uri url = Uri.parse('http://18.222.191.166/login');
    Map<String, String> headers = {"Content-type": "application/json"};
    Map params = {"usuario": login, "senha": senha};

    var body = json.encode(params);
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> retorno = json.decode(response.body);
      loginModel = LoginModel.fromJson(retorno);
      var token = loginModel.accessToken;
      PrefsLogin.salvarToken(token);
      PrefsLogin.salvarAuth(login);
    } else if (response.statusCode == 400) {
      Map<String, dynamic> retorno = json.decode(response.body);
      loginModel = LoginModel.fromJson(retorno);
    } else {
      return null;
    }

    return loginModel;
  }
}
