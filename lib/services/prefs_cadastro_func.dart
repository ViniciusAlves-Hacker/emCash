import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsCadastroFunc {
  static final String _keyNome = 'nome';
  static final String _keyCpf = 'cpf';
  static final String _keyCnpj = 'cnpj';
  static final String _keyCelular = 'celular';
  static final String _keyEmail = 'email';
  static final String _keyStatusCode = 'statusCode';
  static final String _keyId = 'id';




//================================  SALVAR DADOS   ================================

  static salvarNome(String? nome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoNome = await prefs.setString(
      _keyNome,
      jsonEncode(
        {'nome': nome},
      ),
    );
    return dadoNome;
  }

  static salvarCpf(String? cpf) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoCpf = await prefs.setString(
      _keyCpf,
      jsonEncode(
        {'cpf': cpf},
      ),
    );
    return dadoCpf;
  }

  static salvarCnpj(String? cnpj) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoCnpj = await prefs.setString(
      _keyCnpj,
      jsonEncode(
        {'cnpj': cnpj},
      ),
    );
    return dadoCnpj;
  }

  static salvarCelular(String? celular) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoCelular = await prefs.setString(
      _keyCelular,
      jsonEncode(
        {'celular': celular},
      ),
    );
    return dadoCelular;
  }

  static salvarEmail(String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoEmail = await prefs.setString(
      _keyEmail,
      jsonEncode(
        {'email': email},
      ),
    );
    return dadoEmail;
  }

  static salvarStatusCode(String? statusCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoStatusCode = await prefs.setString(
      _keyStatusCode,
      jsonEncode(
        {'statusCode': statusCode},
      ),
    );
    return dadoStatusCode;
  }

  static salvarId(String? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoId = await prefs.setString(
      _keyId,
      jsonEncode(
        {'id': id},
      ),
    );
    return dadoId;
  }




//================================  RECUPERAR DADOS   ================================

  static recuperarNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyNome);
    if (jsonResult != null) {
      var mapNome = await json.decode(jsonResult);
      return mapNome["nome"];
    }
  }

  static recuperarCpf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyCpf);
    if (jsonResult != null) {
      var mapCpf = await json.decode(jsonResult);
      return mapCpf["cpf"];
    }
  }

  static recuperarCnpj() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyCnpj);
    if (jsonResult != null) {
      var mapCnpj = await json.decode(jsonResult);
      return mapCnpj["cnpj"];
    }
  }

  static recuperarCelular() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyCelular);
    if (jsonResult != null) {
      var mapCelular = await json.decode(jsonResult);
      return mapCelular["celular"];
    }
  }

  static recuperarEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyEmail);
    if (jsonResult != null) {
      var mapEmail = await json.decode(jsonResult);
      return mapEmail["email"];
    }
  }

  static recuperarStatusCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyStatusCode);
    if (jsonResult != null) {
      var mapStatusCode = await json.decode(jsonResult);
      return mapStatusCode["statusCode"];
    }
  }

  static recuperarId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyId);
    if (jsonResult != null) {
      var mapId = await json.decode(jsonResult);
      return mapId["id"];
    }
  }


//================================  EXCLUIR DADOS   ================================

  static removerNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyNome);
    return result;
  }

  static removerCpf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyCpf);
    return result;
  }

  static removerCnpj() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyCnpj);
    return result;
  }

  static removerCelular() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyCelular);
    return result;
  }

  static removerEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyEmail);
    return result;
  }

  static removerStatusCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyStatusCode);
    return result;
  }

  static removerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyId);
    return result;
  }

}
