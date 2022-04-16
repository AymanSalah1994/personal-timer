import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final String text;
  final double widthSize;
  final Color color;
  final VoidCallback onPressed;
  ProductivityButton({
    required this.text,
    required this.widthSize,
    required this.color,
    required this.onPressed,
  });
  // Constructor

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        '${this.text}',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.widthSize,
    );
  }
}
