import 'package:flutter/material.dart';

enum ButtonType { elevated, icon, text, filled, outlined }

class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double padding;
  final double borderRadius;
  final double? iconSize;

  const CustomButton({
    Key? key,
    this.text,
    this.icon,
    required this.onPressed,
    this.buttonType = ButtonType.elevated,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.padding = 12.0,
    this.borderRadius = 8.0,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          child: _buildChild(),
        );
      case ButtonType.icon:
        return IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: textColor, size: iconSize ?? 24.0),
          padding: EdgeInsets.all(padding),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor,
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
            textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          child: _buildChild(),
        );
      case ButtonType.filled:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          child: _buildChild(),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: backgroundColor,
            side: BorderSide(color: backgroundColor, width: 2.0),
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          child: _buildChild(),
        );
    }
  }

  Widget _buildChild() {
    if (buttonType == ButtonType.icon) {
      return Icon(icon, color: textColor, size: iconSize ?? 24.0);
    }
    if (text != null && icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: iconSize ?? 20.0),
          SizedBox(width: 8.0),
          Text(text!, style: TextStyle(fontSize: fontSize)),
        ],
      );
    }
    return Text(text ?? '', style: TextStyle(fontSize: fontSize));
  }
}
