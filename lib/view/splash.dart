import 'package:em_cash/controller/lista_func_controller.dart';
import 'package:em_cash/services/prefs_login.dart';
import 'package:em_cash/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState(); 
    

    Future.wait([
      PrefsLogin.recuperarAuth(),      
      Future.delayed(const Duration(seconds:1)),
    ]).then((value) => value[0]
        ? Navigator.of(context).pushReplacementNamed(Routes.HOMEPAGE) // adicionar destino de navegação
        : Navigator.of(context).pushReplacementNamed(Routes.LOGIN));        
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
