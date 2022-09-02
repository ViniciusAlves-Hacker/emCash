import 'package:em_cash/model/editar_func_model.dart';
import 'package:em_cash/model/excluir_func_model.dart';
import 'package:em_cash/repositories/editar_func_api.dart';
import 'package:em_cash/repositories/excluir_func_api.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:flutter/material.dart';

class ExcluirFuncControllerProvider extends ChangeNotifier {
  ExcluirFuncModel excluirFuncModel = ExcluirFuncModel();

  ExcluirFuncApi repository = ExcluirFuncApi();

  Future excluirfuncData() async {
    excluirFuncModel = await repository.excluirFuncionario();
    PrefsCadastroFunc.removerId;
    notifyListeners();
    return excluirFuncModel;
  }
}
