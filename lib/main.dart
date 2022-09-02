import 'package:em_cash/services/providers.dart';
import 'package:em_cash/utils/routes.dart';
import 'package:em_cash/view/home.dart';
import 'package:em_cash/view/login.dart';
import 'package:em_cash/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyTest(),
    ),
  );
}

class MyTest extends StatelessWidget {
  const MyTest({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: "Pacto Administradora",
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 226, 217, 217)),
      initialRoute: '/login',
      routes: {
        Routes.SPLASH: (_) => const SplashPage(),
        Routes.LOGIN: (context) => Login(),
        Routes.HOMEPAGE:(context) => const HomePage(),
      },
    );
  }
}
