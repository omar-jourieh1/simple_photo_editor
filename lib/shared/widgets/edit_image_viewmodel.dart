import 'dart:typed_data';

import 'package:basic_image_editor/models/text_info.dart';
import 'package:basic_image_editor/screens/edit_image_screen.dart';
import 'package:basic_image_editor/shared/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../utils/utils.dart';

abstract class EditImagViewModel extends State<EditImageFileScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  int currentIndex = 0;
  saveToGallery(BuildContext context) {
    if (textInfo.isNotEmpty) {
      screenshotController
          .capture()
          .then((Uint8List? image) => {
                saveImageToGallery(image!),
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Image Has Been Saved',
                )))
              })
          .catchError((err) => print(err));
    }
  }

  saveImageToGallery(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', "-");
    final name = 'Screenshot_$time';
    await requestPermisission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Selected For Styling',
    )));
  }

  List<TextInfo> textInfo = [];
  addNewText(context) {
    setState(() {
      textInfo.add(TextInfo(
          text: textEditingController.text,
          color: Colors.black,
          left: 0,
          textAlign: TextAlign.center,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          top: 0));
      Navigator.of(context).pop();
    });
  }

  changeTextColor(Color color) {
    setState(() {
      textInfo[currentIndex].color = color;
    });
  }

  changeTextAlign(TextAlign textalign) {
    setState(() {
      textInfo[currentIndex].textAlign = textalign;
    });
  }

  inCreaseFontSize() {
    setState(() {
      textInfo[currentIndex].fontSize += 2;
    });
  }

  deCreaseFontSize() {
    setState(() {
      textInfo[currentIndex].fontSize -= 2;
    });
  }

  changeFontStyle(FontStyle fontStyle) {
    setState(() {
      if (textInfo[currentIndex].fontStyle == FontStyle.italic) {
        textInfo[currentIndex].fontStyle = FontStyle.normal;
      } else {
        textInfo[currentIndex].fontStyle = fontStyle;
      }
    });
  }

  changeFontWeight(FontWeight fontWeight) {
    setState(() {
      if (textInfo[currentIndex].fontWeight == FontWeight.bold) {
        textInfo[currentIndex].fontWeight = FontWeight.normal;
      } else {
        textInfo[currentIndex].fontWeight = fontWeight;
      }
    });
  }

  addlinesToText() {
    setState(() {
      if (textInfo[currentIndex].text.contains("\n")) {
        textInfo[currentIndex].text =
            textInfo[currentIndex].text.replaceAll("\n", " ");
      } else {
        textInfo[currentIndex].text =
            textInfo[currentIndex].text.replaceAll(" ", "\n");
      }
    });
  }

  removeText(BuildContext context) {
    setState(() {
      textInfo.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Text Has Deleted',
    )));
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add New Text'),
              content: TextField(
                textCapitalization: TextCapitalization.words,
                controller: textEditingController,
                maxLines: 5,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    filled: true,
                    hintText: 'Your Text Here..'),
              ),
              actions: <Widget>[
                DefaultButton(
                    onPressed: () => addNewText(context),
                    color: Colors.white38,
                    textColor: Colors.black,
                    child: const Text('Add Text')),
                DefaultButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.white38,
                    textColor: Colors.black,
                    child: const Text('Back')),
              ],
            ));
  }
}
