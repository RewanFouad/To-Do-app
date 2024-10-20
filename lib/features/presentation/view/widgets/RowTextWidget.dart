import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  RowText({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}
