import 'package:em_cash/alert/alert.dart';
import 'package:em_cash/alert/criar_cadastro_func.dart';
import 'package:em_cash/alert/edtar_cadastro_func.dart';
import 'package:em_cash/alert/excluir_cadastro_func.dart';
import 'package:em_cash/alert/alert_excluir_selecao.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  TextEditingController nome = TextEditingController();
  TextEditingController documento = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController nomeEditar = TextEditingController();
  TextEditingController documentoEditar = TextEditingController();
  TextEditingController celularEditar = TextEditingController();
  TextEditingController emailEditar = TextEditingController();
  TextEditingController idEditar = TextEditingController();
  List newListId = [];
  var quantSelecionado = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraint) {
        var largura = constraint.maxWidth;
        var altura = MediaQuery.of(context).size.height;
        int quant;

        return Consumer<ListaFuncControllerProvider>(
          builder: (context, value, _) {
            quant = value.map.length;

            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 80, right: 80, bottom: 0),
              child: SizedBox(
                height: altura,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: largura,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Lista de funcionários",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.orange[500],
                                    minimumSize: const Size(120, 50),
                                  ),
                                  onPressed: () {
                                    cadastrarFuncionario(context, nome,
                                        documento, celular, email, cpf, cnpj);
                                  },
                                  child: const Text("Adicionar novo"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Selecionados(${newListId.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  primary: Colors.orange[500],
                                  minimumSize: const Size(120, 50),
                                ),
                                onPressed: () async {
                                  quantSelecionado = newListId.length;
                                  alertExcluirSelecao(
                                      context, newListId, quantSelecionado);
                                  newListId = [];
                                },
                                child: const Text("Apagar seleção"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    quant == 0
                        ? Container(
                            color: Colors.red[50],
                            height: 30,
                            width: largura,
                            child: const Center(
                                child: Text(
                              "Nenhum funcionario cadastrado",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          )
                        : Container(
                            width: largura,
                            height: 50,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: largura * 0.05,
                                ),
                                SizedBox(
                                  width: largura * 0.20,
                                  child: const Text(
                                    "Nome Completo",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: largura * 0.15,
                                  child: const Text(
                                    "CPF / CNPJ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: largura * 0.15,
                                  child: const Text(
                                    "Celular",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: largura * 0.20,
                                  child: const Text(
                                    "E-mail",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: largura * 0.05,
                                  child: const Text(
                                    "Editar",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: largura * 0.05,
                                  child: const Text(
                                    "Apagar",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(
                      width: largura,
                      height: altura - 300,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        color: Colors.grey[100],
                      ),
                      child: ListView.builder(
                        itemCount: quant,
                        itemBuilder: (BuildContext context, int index) {
                          var id = value.map[index]['id'];
                          var nome = value.map[index]['nome'];
                          var cpf = value.map[index]['cpf'];
                          var cnpj = value.map[index]['cnpj'];
                          var celular = value.map[index]['celular'];
                          var email = value.map[index]['email'];

                          return GestureDetector(
                            child: Container(
                              width: largura,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: largura * 0.05,
                                      child: Checkbox(
                                        value: newListId.contains(id),
                                        onChanged: (newValue) {
                                          setState(() {
                                            if (newListId.contains(id)) {
                                              newListId
                                                  .removeWhere((e) => e == id);
                                            } else {
                                              newListId.add(id);
                                            }
                                          });
                                        },
                                      )),
                                  SizedBox(
                                    width: largura * 0.20,
                                    child: Text(
                                      "$nome",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: largura * 0.15,
                                    child: Text(
                                      cpf ?? cnpj,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: largura * 0.15,
                                    child: Text(
                                      "$celular",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: largura * 0.20,
                                    child: Text(
                                      "$email",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: largura * 0.05,
                                    child: GestureDetector(
                                      onTap: () {
                                        idEditar.text = id;
                                        nomeEditar.text = nome;
                                        cpf != null
                                            ? documentoEditar.text = cpf
                                            : null;
                                        cnpj != null
                                            ? documentoEditar.text = cnpj
                                            : null;
                                        celularEditar.text = celular;
                                        emailEditar.text = email;
                                        editarFuncionario(
                                            context,
                                            idEditar,
                                            nomeEditar,
                                            documentoEditar,
                                            celularEditar,
                                            emailEditar);
                                      },
                                      child: Image.asset(
                                        "images/pencil.png",
                                        color: Colors.orange[600],
                                        height: 23,
                                        width: 23,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: largura * 0.05,
                                    child: GestureDetector(
                                      onTap: () {
                                        idEditar.text = id;
                                        excluirCadastro(context, id);
                                      },
                                      child: Image.asset(
                                        "images/trash.png",
                                        color: Colors.orange[600],
                                        height: 23,
                                        width: 23,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
