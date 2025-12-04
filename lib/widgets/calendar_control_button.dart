import 'package:flutter/material.dart';

class CalendarControlButton extends StatelessWidget {
  const CalendarControlButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.borderColor,
    required this.backgroundColor,
    this.iconColor,
  });

  final VoidCallback onTap;
  final IconData icon;
  final Color borderColor;
  final Color backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
