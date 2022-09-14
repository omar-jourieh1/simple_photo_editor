import 'package:basic_image_editor/models/text_info.dart';
import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({Key? key, required this.textInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        textInfo.text,
        textAlign: textInfo.textAlign,
        style: TextStyle(
            fontStyle: textInfo.fontStyle,
            color: textInfo.color,
            fontSize: textInfo.fontSize,
            fontWeight: textInfo.fontWeight),
      );
}
