import 'package:flutter/material.dart';

class TextInfo {
  TextInfo(
      {required this.text,
      required this.color,
      required this.left,
      required this.textAlign,
      required this.fontSize,
      required this.fontWeight,
      required this.fontStyle,
      required this.top});
  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;
}
