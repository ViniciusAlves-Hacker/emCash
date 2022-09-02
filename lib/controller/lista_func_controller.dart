//CONTROLANDO A CHAMADA DA FUNÇÃO E NOTIFICANDO QUANDO MUDA O VALOR DO RETORNO
import 'package:em_cash/model/lista_funcionarios_model.dart';
import 'package:em_cash/repositories/lista_func_api.dart';
import 'package:flutter/material.dart';

class ListaFuncControllerProvider extends ChangeNotifier {
  ListaFuncionariosModel listaFuncionariosModel = ListaFuncionariosModel();

  List<Map<String, dynamic>> map = [];


  ListaFuncApi repository = ListaFuncApi();

  Future getUserData() async {
    map = await repository.dadosFuncionarios();
    notifyListeners();
    return map;
  }
}