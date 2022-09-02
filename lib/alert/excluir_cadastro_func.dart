import 'package:em_cash/alert/alert.dart';
import 'package:em_cash/controller/excluir_func_controller.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

excluirCadastro(BuildContext context, id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Apagar funcionário(s)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )),
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width: 350,
            child: Text(
                "Essa ação é irreversível. Tem certeza que deseja apagar este(s) funcionário(s) do sistema?"),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                    child: Text(
                  "Cancelar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                  ),
                )),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(130, 40),
                  primary: Colors.orange[700],
                  elevation: 12,
                  shadowColor: Colors.grey[400],
                ),
                onPressed: () async {
                  PrefsCadastroFunc.salvarId(id);

                  var controller = Provider.of<ExcluirFuncControllerProvider>(
                      context,
                      listen: false);
                  var retorno = await controller.excluirfuncData();

                  if (retorno != null) {
                    var statusCode =
                        await PrefsCadastroFunc.recuperarStatusCode();
                    var status = int.parse(statusCode);
                    if (status == 200) {
                      var controllerFunc =
                          Provider.of<ListaFuncControllerProvider>(context,
                              listen: false);

                      List<Map<String, dynamic>> map =
                          await controllerFunc.getUserData();

                      PrefsCadastroFunc.removerId();

                      Navigator.pop(context);

                      alert(context, "Funcionario excluido com sucesso");
                    } else {
                      var controllerFunc =
                          Provider.of<ListaFuncControllerProvider>(context,
                              listen: false);

                      List<Map<String, dynamic>> map =
                          await controllerFunc.getUserData();

                      PrefsCadastroFunc.removerId();

                      Navigator.pop(context);

                      alert(context, "Não foi possivel excluir o funcionário.");
                    }
                  }
                },
                child: const Text("Apagar"),
              )
            ],
          ),
        ],
      );
    },
  );
}
