import 'package:flutter/material.dart';
import 'package:tell_am/utils/dimensions.dart';

class HeadText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;

  HeadText({
    super.key,
    this.color = const Color(0xFF332d2b), // Default color
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size == 0 ? Dimensions.font30 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
