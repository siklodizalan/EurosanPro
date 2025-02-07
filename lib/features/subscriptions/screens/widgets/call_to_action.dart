import 'package:flutter/material.dart';

class CallToActionButton extends StatelessWidget {
  const CallToActionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.subText,
    this.backgroundColor,
    this.textColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
    this.borderRadius = 50.0,
    this.fontSize = 24.0,
    this.subTextFontSize = 13.0,
    this.enabled = true,
  });

  final String buttonText;
  final String? subText;
  final Color? backgroundColor;
  final Color textColor;
  final EdgeInsets padding;
  final double borderRadius;
  final double fontSize;
  final double subTextFontSize;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? (backgroundColor ?? Theme.of(context).primaryColor) : Colors.grey,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Column(
        children: [
          Text(
            buttonText,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          if (subText != null)
            Text(
              subText!,
              style: TextStyle(
                fontSize: subTextFontSize,
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }
}
