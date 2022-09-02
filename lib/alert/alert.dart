import 'package:brasil_fields/brasil_fields.dart';
import 'package:em_cash/controller/cadastro_func_controller.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:em_cash/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

alert(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(
            child: Text(
          "ATENÇÃO",
          style: TextStyle(color: Colors.red),
        )),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(msg),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Center(child: Text("ok")),
          ),
        ],
      );
    },
  );
}

alertSair(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Sair",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )),
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width: 350,
            child: Text(
                "Tem certeza que deseja sair?"),
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
                  fixedSize: const Size(100, 40),
                  primary: Colors.orange[700],
                  elevation: 12,
                  shadowColor: Colors.grey[400],
                ),
                onPressed: () {
                  PrefsLogin.logout();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(Routes.LOGIN, (_) => true);
                },
                child: const Text("sair"),
              )
            ],
          ),
        ],
      );
    },
  );
}
