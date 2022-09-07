import 'package:flutter/material.dart';
import 'package:flutter_game/core/style.dart';

// ignore: must_be_immutable
class Mybutton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  var buttonColor = Colors.deepPurple[400];
  Mybutton({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == "C") {
      buttonColor = Colors.green;
    } else if (child == "DEL") {
      buttonColor = const Color.fromARGB(255, 184, 18, 18);
    } else if (child == "=") {
      buttonColor = Colors.deepPurple;
    }
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Center(
            child: Text(
              child,
              style: myStyle,
            ),
          ),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
