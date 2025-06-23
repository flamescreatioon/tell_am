import 'package:flutter/material.dart';
import 'package:tell_am/utils/diementions.dart';

class BigText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({
    Key? key,
    this.color = const Color(0xFF332d2b), // Default color
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?Diementions.font20:size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}