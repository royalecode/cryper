import 'package:cryper/constantes_app.dart';
import 'package:flutter/material.dart';


class TabFavoritos extends StatefulWidget {
  const TabFavoritos({Key? key}) : super(key: key);

  @override
  _TabFavoritos createState() => _TabFavoritos();
}

class _TabFavoritos extends State<TabFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: const Center(
          child: Text("Pagina Favoritos",style: TextStyle(color: Colors.white,fontSize: 30),),
        ),

      ),
    );
  }
}