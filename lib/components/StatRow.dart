import 'package:cryper/constantes_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  IconData? iconData;
  String label;
  String value;

  StatRow({
    Key? key,
    this.iconData,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Icon(
            iconData,
            color: lightBlueColor,
            size: 24,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 14, fontFamily: "Inter")
                  ),
                  Text(
                    value,
                    style: TextStyle(fontSize: 14, fontFamily: "Inter", color: Color(0xFF8894B3)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
