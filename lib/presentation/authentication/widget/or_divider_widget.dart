import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final Color color;
  const OrDivider({this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: color)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("Or",),
        ),
        Expanded(child: Container(height: 1, color: color)),
      ],
    );
  }
}
