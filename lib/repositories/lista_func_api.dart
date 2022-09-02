import 'dart:convert';
import 'dart:io';
import 'package:em_cash/services/prefs_login.dart';
import 'package:http/http.dart' as http;

class ListaFuncApi {
  dadosFuncionarios() async {

    List<Map<String, dynamic>> map = [];

    var token = await PrefsLogin.recuperarToken();

    Uri url = Uri.parse('http://18.222.191.166/funcionarios');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "Bearer $token",
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      map = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      
    } else if (response.statusCode == 400) {
      map = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      return null;
    }

    return map;
  }
}
