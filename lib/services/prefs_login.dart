import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsLogin {
  static final String _keyToken = 'token';
  static final String _keyLogin = 'login';
  static final String _keySenha = 'senha';
  static final String _keyAuth = 'auth';

//================================  SALVAR DADOS   ================================

  static salvarToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoToken = await prefs.setString(
      _keyToken,
      jsonEncode(
        {'token': token},
      ),
    );
    return dadoToken;
  }

  static salvarLogin(String login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoLogin = await prefs.setString(
      _keyLogin,
      jsonEncode(
        {'login': login},
      ),
    );
    return dadoLogin;
  }

  static salvarSenha(String senha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoSenha = await prefs.setString(
      _keySenha,
      jsonEncode(
        {'senha': senha},
      ),
    );
    return dadoSenha;
  }

  static salvarAuth(String usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dadoAuth = await prefs.setString(
      _keyAuth,
      jsonEncode(
        {
          'user': usuario,
          'auth': true,
        },
      ),
    );
    return dadoAuth;
  }

//================================  RECUPERAR DADOS   ================================

  static recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyToken);
    if (jsonResult != null) {
      var mapToken = await json.decode(jsonResult);
      return mapToken["token"];
    }
  }

  static recuperarLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keyLogin);
    if (jsonResult != null) {
      var mapLogin = await json.decode(jsonResult);
      return mapLogin["login"];
    }
  }

  static recuperarSenha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = await prefs.getString(_keySenha);
    if (jsonResult != null) {
      var mapSenha = await json.decode(jsonResult);
      return mapSenha["senha"];
    }
  }

  static Future<bool> recuperarAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_keyAuth);
    if (jsonResult != null) {
      var mapAuth = jsonDecode(jsonResult);
      return mapAuth['auth'];
    }

    return false;
  }

  static recuperarUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_keyAuth);
    if (jsonResult != null) {
      var mapAuth = jsonDecode(jsonResult);
      return mapAuth['user'];
    }
  }

//================================  EXCLUIR DADOS   ================================

  static removerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyToken);
    return result;
  }

  static removerLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keyLogin);
    return result;
  }

  static removerSenha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(_keySenha);
    return result;
  }

  static logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAuth);
  }
}
