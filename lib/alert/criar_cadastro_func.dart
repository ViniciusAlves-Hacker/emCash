import 'package:brasil_fields/brasil_fields.dart';
import 'package:em_cash/alert/alert.dart';
import 'package:em_cash/controller/cadastro_func_controller.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/services/prefs_cadastro_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


cadastrarFuncionario(
  BuildContext context,
  TextEditingController nome,
  TextEditingController documento,
  TextEditingController celular,
  TextEditingController email,
  TextEditingController cpf,
  TextEditingController cnpj,
) {
  showDialog(
    context: context,
    builder: (context) {
      final formKey = GlobalKey<FormState>();
      return AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Adicionar novo funcionário",
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
                            controller: documento,
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
                              labelText: "CPF/CNPJ",
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "O campo é obrigatório";
                              }
                              if (value.length != 14 && value.length != 18) {
                                return "Informar um valor válido";
                              }
                              if (value.length == 14) {
                                var cpfFormater = documento.text
                                    .replaceAll(new RegExp(r'[^\w\s]+'), '');
                                PrefsCadastroFunc.salvarCpf(cpfFormater);
                              }
                              if (value.length == 18) {
                                var cnpjFormater = documento.text
                                    .replaceAll(new RegExp(r'[^\w\s]+'), '');
                                PrefsCadastroFunc.salvarCnpj(cnpjFormater);
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfOuCnpjFormatter()
                            ],
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
                              if (value.isNotEmpty) {
                                var celularFormater = celular.text
                                    .replaceAll("-", "")
                                    .replaceAll("(", "")
                                    .replaceAll(")", "")
                                    .replaceAll(" ", "");
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
                        fixedSize: const Size(120, 40),
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
                        } else {
                          PrefsCadastroFunc.removerNome();
                          PrefsCadastroFunc.removerCpf();
                          PrefsCadastroFunc.removerCnpj();
                          PrefsCadastroFunc.removerCelular();
                          PrefsCadastroFunc.removerEmail();
                        }

                        var controller =
                            Provider.of<CadastrarFuncControllerProvider>(
                                context,
                                listen: false);
                        var retorno = await controller.cadastrofuncData();

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

                            nome.text = "";
                            documento.text = "";
                            celular.text = "";
                            email.text = "";

                            PrefsCadastroFunc.removerNome();
                            PrefsCadastroFunc.removerCpf();
                            PrefsCadastroFunc.removerCnpj();
                            PrefsCadastroFunc.removerCelular();
                            PrefsCadastroFunc.removerEmail();

                            Navigator.pop(context);

                            alert(
                                context, "Funcionario cadastrado com sucesso");
                          } else {
                            var controllerFunc =
                                Provider.of<ListaFuncControllerProvider>(
                                    context,
                                    listen: false);

                            List<Map<String, dynamic>> map =
                                await controllerFunc.getUserData();

                            nome.text = "";
                            documento.text = "";
                            celular.text = "";
                            email.text = "";
                            
                            PrefsCadastroFunc.removerNome();
                            PrefsCadastroFunc.removerCpf();
                            PrefsCadastroFunc.removerCnpj();
                            PrefsCadastroFunc.removerCelular();
                            PrefsCadastroFunc.removerEmail();

                            Navigator.pop(context);
                            alert(context, "Não foi possivel cadastrar funcionário com os dados fornecidos.");
                          }                          
                        }
                      },
                      child: const Text("Adicionar"),
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
