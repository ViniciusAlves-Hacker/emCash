import 'dart:convert';
import 'dart:io';
import 'package:em_cash/model/editar_func_model.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:http/http.dart' as http;

class EditarFuncApi {
  editarFuncionario() async {
    EditarFuncModel editarFuncModel = EditarFuncModel();

    var token = await PrefsLogin.recuperarToken();
    var id = await PrefsCadastroFunc.recuperarId();
    var nome = await PrefsCadastroFunc.recuperarNome();
    var celular = await PrefsCadastroFunc.recuperarCelular();
    var email = await PrefsCadastroFunc.recuperarEmail();

    Uri url = Uri.parse('http://18.222.191.166/funcionario/$id');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    Map params = {
      "nome": nome,
      "celular": celular,
      "email": email,
    };

    var body = json.encode(params);
    var response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var status = response.statusCode;
      PrefsCadastroFunc.salvarStatusCode(status.toString());
      Map<String, dynamic> retorno = json.decode(response.body);
      editarFuncModel = EditarFuncModel.fromJson(retorno);
    } else if (response.statusCode != 200) {
      var status = response.statusCode;
      PrefsCadastroFunc.salvarStatusCode(status.toString());
      Map<String, dynamic> retorno = json.decode(response.body);
      editarFuncModel = EditarFuncModel.fromJson(retorno);
    } else {
      return null;
    }

    return editarFuncModel;
  }
}
