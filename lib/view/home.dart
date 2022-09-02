import 'package:em_cash/components/body_home.dart';
import 'package:em_cash/components/header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var largura = constraint.maxWidth;

      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size(largura, 50),
            child: const Header(),
          ),
          body: const SingleChildScrollView(
            child: BodyHomePage()
          ),
        ),
      );
    });
    
  }
}