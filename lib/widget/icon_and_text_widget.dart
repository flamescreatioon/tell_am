import 'package:flutter/material.dart';
import 'package:tell_am/utils/dimentions.dart';
import 'package:tell_am/widget/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color color;
  final double size;

  const IconAndTextWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimentions.iconSize24, // Adjust the size as needed
        ),
        const SizedBox(width: 3), // Add some space between icon and text
        SmallText(
          text: text,
          size: 12, // Adjust the size as needed
        ),
      ],
    );
  }
}
