//CONTROLANDO A CHAMADA DA FUNÇÃO E NOTIFICANDO QUANDO MUDA O VALOR DO RETORNO
import 'package:em_cash/model/cadastro_func_model.dart';
import 'package:em_cash/model/lista_funcionarios_model.dart';
import 'package:em_cash/repositories/cadastrar_func_api.dart';
import 'package:em_cash/repositories/lista_func_api.dart';
import 'package:flutter/material.dart';

class CadastrarFuncControllerProvider extends ChangeNotifier {
  CadastroFuncModel cadastroFuncModel = CadastroFuncModel();

  CadastrarFuncApi repository = CadastrarFuncApi();

  Future cadastrofuncData() async {
    cadastroFuncModel = await repository.cadastrarFuncionario();
    notifyListeners();
    return cadastroFuncModel;
  }
}
