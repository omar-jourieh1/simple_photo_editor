import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.color,
      required this.textColor})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(color: textColor))),
      onPressed: onPressed,
      child: child);
}
