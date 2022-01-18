import 'package:cryper/constantes_app.dart';
import 'package:flutter/material.dart';


class TabPerfil extends StatefulWidget {
  const TabPerfil({Key? key}) : super(key: key);

  @override
  _TabPerfil createState() => _TabPerfil();
}

class _TabPerfil extends State<TabPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: const Center(
          child: Text("Pagina Perfil",style: TextStyle(color: Colors.white,fontSize: 30),),


      ),

      ),
    );
  }
}