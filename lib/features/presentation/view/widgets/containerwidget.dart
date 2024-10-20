import 'package:flutter/material.dart';
import 'package:todo_app/features/presentation/view/widgets/RowTextWidget.dart';

class ContainerWidget extends StatefulWidget {
  ContainerWidget({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: Color(0xFF3dffe3), borderRadius: BorderRadius.circular(20)),
        child: RowText(text: widget.text),
      ),
    );
  }
}
