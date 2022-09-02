import 'package:em_cash/alert/alert.dart';
import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/controller/login_controller.dart';
import 'package:em_cash/model/lista_funcionarios_model.dart';
import 'package:em_cash/model/login_model.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:em_cash/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loading = ValueNotifier<bool>(false);
  final login = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final erroLogin = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        var largura = constraint.maxWidth;
        var altura = MediaQuery.of(context).size.height;
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 205, 204, 204),
          body: Container(
            width: largura,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: AlignmentDirectional.centerStart,
                image: AssetImage("images/banner.png"),
                fit: BoxFit.none,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: largura * 0.50,
                      height: altura,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 40, left: 120),
                            child:
                                Image(image: AssetImage("images/emcash.png")),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 40, left: 120),
                            child: Text(
                              "O investimento evoluiu. O emprestimo Também.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: largura * 0.50,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 320,
                            height: 400,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Seja Bem-Vindo",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: const [
                                        Text(
                                          "Insira os seus dados nos campos abaixo para acessar sua conta.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: login,
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      labelText: "Usuário",
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "O campo é obrigatório";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: senha,
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      labelText: "Senha",
                                    ),
                                    obscureText: true,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "O campo é obrigatório";
                                      }
                                      return null;
                                    },
                                  ),
                                  AnimatedBuilder(
                                    animation: erroLogin,
                                    builder: (context, _) {
                                      return erroLogin.value
                                          ? Container(
                                              width: largura,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.red[50],
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.red[900],
                                                  ),
                                                  Text(
                                                    "Usuario e/ou senha incorretos.",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.red[900],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.red[900],
                                                    ),
                                                    onPressed: () {
                                                      erroLogin.value =
                                                          !erroLogin.value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "Esqueci minha senha",
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            245, 124, 0, 1),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      onPressed: () {
                                        loading.value = !loading.value;
                                        _botaoLogin(context);
                                      },
                                      child: loading.value
                                          ? const CircularProgressIndicator()
                                          : const Text("Entrar"),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Ainda não tem conta?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " Cadastrar",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _botaoLogin(BuildContext context) async {
    bool formok = formKey.currentState!.validate();

    if (!formok) {
      return;
    }

    if (formok == true) {
      PrefsLogin.salvarLogin(login.text);
      PrefsLogin.salvarSenha(senha.text);
    }

    var controller =
        Provider.of<LoginControllerProvider>(context, listen: false);

    LoginModel loginModel = await controller.getUserData();

    if (loginModel.accessToken != null) {
      var controllerFunc =
          Provider.of<ListaFuncControllerProvider>(context, listen: false);

      List<Map<String, dynamic>> map = await controllerFunc.getUserData();

      _navegacaoLogin(context);
    } else {
      erroLogin.value = !erroLogin.value;
      loading.value = false;
    }
  }

  _navegacaoLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.HOMEPAGE, (_) => false);
  }
}
