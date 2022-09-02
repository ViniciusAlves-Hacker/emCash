import 'package:em_cash/model/login_model.dart';
import 'package:em_cash/repositories/login_api.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//CONTROLANDO A CHAMADA DA FUNÇÃO E NOTIFICANDO QUANDO MUDA O VALOR DO RETORNO
class LoginControllerProvider extends ChangeNotifier {
  LoginModel? loginModel;

  LoginApi repository = LoginApi();

  Future getUserData() async {
    var login = await PrefsLogin.recuperarLogin();
    var senha = await PrefsLogin.recuperarSenha();
    loginModel = await repository.login(login, senha);
    notifyListeners();
    return loginModel;
  }
}
