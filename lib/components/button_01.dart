import 'package:flutter/material.dart';

class Button01 extends StatelessWidget {
  final VoidCallback onPressed;
    final Color? textColor;
    final double? fontSize;
    final String text;

    const Button01({
      super.key,
      required this.textColor,
      required this.onPressed,
      this.fontSize,
      required this.text,
    });
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    

    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
      ),
    )
    );
  }
}