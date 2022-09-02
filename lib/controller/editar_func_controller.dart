import 'package:em_cash/model/editar_func_model.dart';
import 'package:em_cash/repositories/editar_func_api.dart';
import 'package:flutter/material.dart';

class EditarFuncControllerProvider extends ChangeNotifier {
  
  EditarFuncModel editarFuncModel = EditarFuncModel();

  EditarFuncApi repository = EditarFuncApi();

  Future editarfuncData() async {
    editarFuncModel = await repository.editarFuncionario();
    notifyListeners();
    return editarFuncModel;
  }
}
