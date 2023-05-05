import 'package:flutter/material.dart';

class MenuBlock extends StatefulWidget {
  final int emi;
  final int queue;
  final String name;
  const MenuBlock({Key? key, required this.queue, required this.emi,
    required this.name}) : super(key: key);

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

    return AnimatedContainer(
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
      duration: const Duration(milliseconds: 250),
      child:  Align(
        alignment: Alignment.center,
        child: Text(widget.name),
      ),
    );
  }
}
