import 'dart:convert';
import 'dart:io';
import 'package:em_cash/model/cadastro_func_model.dart';
import 'package:em_cash/model/lista_funcionarios_model.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:http/http.dart' as http;

class CadastrarFuncApi {
  cadastrarFuncionario() async {
    CadastroFuncModel cadastroFuncModel = CadastroFuncModel();

    var token = await PrefsLogin.recuperarToken();
    var nome = await PrefsCadastroFunc.recuperarNome();
    var cpf = await PrefsCadastroFunc.recuperarCpf();
    var cnpj = await PrefsCadastroFunc.recuperarCnpj();
    var celular = await PrefsCadastroFunc.recuperarCelular();
    var email = await PrefsCadastroFunc.recuperarEmail();

    Uri url = Uri.parse('http://18.222.191.166/funcionario/cadastro');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    Map params = {
      "nome": nome,
      "cpf": cpf,
      "cnpj": cnpj,
      "celular": celular,
      "email": email,
    };

    var body = json.encode(params);
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var status = response.statusCode;
      PrefsCadastroFunc.salvarStatusCode(status.toString());
      Map<String, dynamic> retorno = json.decode(response.body);
      cadastroFuncModel = CadastroFuncModel.fromJson(retorno);
    } else if (response.statusCode == 400) {
      var status = response.statusCode;
      PrefsCadastroFunc.salvarStatusCode(status.toString());
      Map<String, dynamic> retorno = json.decode(response.body);
      cadastroFuncModel = CadastroFuncModel.fromJson(retorno);
    } else {
      return null;
    }

    return cadastroFuncModel;
  }
}
