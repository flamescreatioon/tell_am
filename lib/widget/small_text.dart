import 'package:flutter/material.dart';
import 'package:tell_am/utils/diementions.dart';

class SmallText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  double height;

  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5), // Default color
    required this.text,
    this.size = 0,
    this.height = 1.2,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?Diementions.font16:size,
        fontWeight: FontWeight.w400,
        height: height, // Adjusts the line height  
      ),
    );
  }
}