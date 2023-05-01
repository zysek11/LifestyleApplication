import 'package:flutter/material.dart';

class MenuBlock extends StatefulWidget {
  final int emi;
  final int queue;
  const MenuBlock({Key? key, required this.queue, required this.emi}) : super(key: key);

  @override
  _MenuBlockState createState() => _MenuBlockState();
}

class _MenuBlockState extends State<MenuBlock> {

  @override
  Widget build(BuildContext context) {

    bool showBorder = false;
    if(widget.queue == widget.emi) {
      showBorder = true;
    } else {
      showBorder = false;
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 25),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 4.0,
            color:  showBorder == true ? const Color(0xFF2E8B57)
                : Colors.grey.shade200,
          ),
        ),
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text("menu1"),
      ),
    );
  }
}
