import 'package:brasil_fields/brasil_fields.dart';
import 'package:em_cash/alert/alert.dart';
import 'package:em_cash/controller/cadastro_func_controller.dart';
import 'package:em_cash/controller/editar_func_controller.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

editarFuncionario(
  BuildContext context,
  TextEditingController id,
  TextEditingController nome,
  TextEditingController documento,
  TextEditingController celular,
  TextEditingController email,
) {
  showDialog(
    context: context,
    builder: (context) {
      final formKey = GlobalKey<FormState>();
      return AlertDialog(
        content: Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Editar funcionário",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: 350,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    height: 320,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: nome,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: "Nome completo",
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "O campo é obrigatório";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            enabled: false,
                            controller: documento,
                            style: const TextStyle(color: Colors.grey),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: "CPF/CNPJ",
                            ),
                            inputFormatters: [CpfOuCnpjFormatter()],
                          ),
                          TextFormField(
                            controller: celular,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: "Celular",
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "O campo é obrigatório";
                              }
                              if (value.length < 13) {
                                return "Digite um telefone valido";
                              }
                              if (!value.isEmpty) {
                                var celularFormater = celular.text
                                    .replaceAll("-", "")
                                    .replaceAll("(", "")
                                    .replaceAll(")", "")
                                    .replaceAll(" ", "");
                                ;
                                PrefsCadastroFunc.salvarCelular(
                                    celularFormater);
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                          ),
                          TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: "E-mail",
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "O campo é obrigatório";
                              }
                              if (!value.contains("@")) {
                                return "E-mail invalido";
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.orange[700]),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(140, 40),
                        primary: Colors.orange[700],
                        elevation: 12,
                        shadowColor: Colors.grey[400],
                      ),
                      onPressed: () async {
                        bool formok = formKey.currentState!.validate();

                        if (!formok) {
                          return;
                        }

                        if (formok == true) {
                          PrefsCadastroFunc.salvarNome(nome.text);
                          PrefsCadastroFunc.salvarEmail(email.text);
                          PrefsCadastroFunc.salvarId(id.text);
                        } else {
                          PrefsCadastroFunc.removerNome();
                          PrefsCadastroFunc.removerCpf();
                          PrefsCadastroFunc.removerCnpj();
                          PrefsCadastroFunc.removerCelular();
                          PrefsCadastroFunc.removerEmail();
                          PrefsCadastroFunc.removerId();
                        }

                        var controller =
                            Provider.of<EditarFuncControllerProvider>(context,
                                listen: false);
                        var retorno = await controller.editarfuncData();

                        if (retorno != null) {
                          var statusCode =
                              await PrefsCadastroFunc.recuperarStatusCode();
                          var status = int.parse(statusCode);
                          if (status == 200) {
                            var controllerFunc =
                                Provider.of<ListaFuncControllerProvider>(
                                    context,
                                    listen: false);

                            List<Map<String, dynamic>> map =
                                await controllerFunc.getUserData();
                                
                            PrefsCadastroFunc.removerNome();
                            PrefsCadastroFunc.removerCpf();
                            PrefsCadastroFunc.removerCnpj();
                            PrefsCadastroFunc.removerCelular();
                            PrefsCadastroFunc.removerEmail();
                            PrefsCadastroFunc.removerId();

                            Navigator.pop(context);

                            alert(context, "Funcionario editado com sucesso");
                          } else {
                            var controllerFunc =
                                Provider.of<ListaFuncControllerProvider>(
                                    context,
                                    listen: false);

                            List<Map<String, dynamic>> map =
                                await controllerFunc.getUserData();

                            PrefsCadastroFunc.removerNome();
                            PrefsCadastroFunc.removerCpf();
                            PrefsCadastroFunc.removerCnpj();
                            PrefsCadastroFunc.removerCelular();
                            PrefsCadastroFunc.removerEmail();
                            PrefsCadastroFunc.removerId();

                            Navigator.pop(context);

                            alert(context, "Não foi possivel edtar os dados do funcionário com os dados fornecidos.");
                          }
                        }
                      },
                      child: const Text("Salvar Alteração"),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
