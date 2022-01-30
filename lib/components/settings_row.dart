import 'package:cryper/constantes_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  IconData iconData;
  String label;
  Function onpress;
  Color? iconColor;

  SettingsRow({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onpress,
    this.iconColor
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [Padding(
                padding: const EdgeInsets.only(left:5, right: 20.0),
                child: Icon(iconData, color: iconColor ?? Theme.of(context).colorScheme.primary),
              ), Text(label, style: const TextStyle(fontSize: 14, fontFamily: "Inter"))],
            ),
          ),
          IconButton(onPressed: (){onpress();}, icon: Icon(Icons.navigate_next),)
        ],
      ),
    );
  }
}
