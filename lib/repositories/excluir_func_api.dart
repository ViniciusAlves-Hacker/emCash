import 'dart:convert';
import 'dart:io';
import 'package:em_cash/model/editar_func_model.dart';
import 'package:em_cash/model/excluir_func_model.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:http/http.dart' as http;

class ExcluirFuncApi {
  excluirFuncionario() async {
    ExcluirFuncModel excluirFuncModel = ExcluirFuncModel();

    var token = await PrefsLogin.recuperarToken();
    var id = await PrefsCadastroFunc.recuperarId();

    Uri url = Uri.parse('http://18.222.191.166/funcionario/$id');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      var status = response.statusCode;
      PrefsCadastroFunc.salvarStatusCode(status.toString());
      Map<String, dynamic> retorno = json.decode(response.body);
      excluirFuncModel = ExcluirFuncModel.fromJson(retorno);
    } else if (response.statusCode != 200) {
      var status = response.statusCode;
      PrefsCadastroFunc.salvarStatusCode(status.toString());
      Map<String, dynamic> retorno = json.decode(response.body);
      excluirFuncModel = ExcluirFuncModel.fromJson(retorno);
    } else {
      return null;
    }

    return excluirFuncModel;
  }
}