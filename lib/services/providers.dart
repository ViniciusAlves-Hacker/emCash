import 'package:em_cash/controller/cadastro_func_controller.dart';
import 'package:em_cash/controller/editar_func_controller.dart';
import 'package:em_cash/controller/excluir_func_controller.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/controller/login_controller.dart';
import 'package:em_cash/repositories/cadastrar_func_api.dart';
import 'package:em_cash/repositories/editar_func_api.dart';
import 'package:em_cash/repositories/excluir_func_api.dart';
import 'package:em_cash/repositories/lista_func_api.dart';
import 'package:em_cash/repositories/login_api.dart';
import 'package:provider/provider.dart';

final providers = [
  
// CONTROLLER LOGIN

  Provider<LoginApi>(
    create: (context) => LoginApi(),
  ),

  ChangeNotifierProvider<LoginControllerProvider>(
      create: (context) => LoginControllerProvider()),



// CONTROLLER LISTA DE FUNCIONÁRIOS

  Provider<ListaFuncApi>(
    create: (context) => ListaFuncApi(),
  ),

  ChangeNotifierProvider<ListaFuncControllerProvider>(
    create: (context) => ListaFuncControllerProvider(),
  ),


// CONTROLLER CADASTRO DE FUNCIONÁRIOS

  Provider<CadastrarFuncApi>(
    create: (context) => CadastrarFuncApi(),
  ),

  ChangeNotifierProvider<CadastrarFuncControllerProvider>(
    create: (context) => CadastrarFuncControllerProvider(),
  ),

// CONTROLLER EDICAO DE FUNCIONÁRIOS

  Provider<EditarFuncApi>(
    create: (context) => EditarFuncApi(),
  ),

  ChangeNotifierProvider<EditarFuncControllerProvider>(
    create: (context) => EditarFuncControllerProvider(),
  ),

// CONTROLLER EXCLUIR DE FUNCIONÁRIOS

  Provider<ExcluirFuncApi>(
    create: (context) => ExcluirFuncApi(),
  ),

  ChangeNotifierProvider<ExcluirFuncControllerProvider>(
    create: (context) => ExcluirFuncControllerProvider(),
  ),

];
