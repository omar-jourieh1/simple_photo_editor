import 'dart:io';

import 'package:basic_image_editor/shared/widgets/Image_text.dart';
import 'package:basic_image_editor/shared/widgets/edit_image_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class EditImageFileScreen extends StatefulWidget {
  const EditImageFileScreen({Key? key, required this.selectedImage})
      : super(key: key);
  final String selectedImage;
  @override
  State<EditImageFileScreen> createState() => _EditImageFileScreenState();
}

class _EditImageFileScreenState extends EditImagViewModel {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 30,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  IconButton(
                    onPressed: () => saveToGallery(context),
                    icon: const Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                    tooltip: 'Save Image',
                  ),
                  IconButton(
                    onPressed: () => inCreaseFontSize(),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    tooltip: 'InCrease Text',
                  ),
                  IconButton(
                    onPressed: () => deCreaseFontSize(),
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                    tooltip: 'deCrease Text',
                  ),
                  IconButton(
                    onPressed: () => changeTextAlign(TextAlign.left),
                    icon: const Icon(
                      Icons.format_align_left,
                      color: Colors.black,
                    ),
                    tooltip: 'Left Center',
                  ),
                  IconButton(
                    onPressed: () => changeTextAlign(TextAlign.center),
                    icon: const Icon(
                      Icons.format_align_center,
                      color: Colors.black,
                    ),
                    tooltip: 'Align Center',
                  ),
                  IconButton(
                    onPressed: () => changeTextAlign(TextAlign.right),
                    icon: const Icon(
                      Icons.format_align_right,
                      color: Colors.black,
                    ),
                    tooltip: 'Align Right',
                  ),
                  IconButton(
                    onPressed: () => changeFontWeight(FontWeight.bold),
                    icon: const Icon(
                      Icons.format_bold,
                      color: Colors.black,
                    ),
                    tooltip: 'Bold',
                  ),
                  IconButton(
                    onPressed: () => changeFontStyle(FontStyle.italic),
                    icon: const Icon(
                      Icons.format_italic,
                      color: Colors.black,
                    ),
                    tooltip: 'Italic',
                  ),
                  IconButton(
                    onPressed: addlinesToText,
                    icon: const Icon(
                      Icons.space_bar,
                      color: Colors.black,
                    ),
                    tooltip: 'Add New Line',
                  ),
                  Tooltip(
                    message: 'White',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.white),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Tooltip(
                    message: 'Red',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.red),
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Tooltip(
                    message: 'Black',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.black),
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Tooltip(
                    message: 'Blue',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.blue),
                      child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Screenshot(
            controller: screenshotController,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: [
                    Center(
                      child: Image.file(
                        File(
                          widget.selectedImage,
                        ),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    for (int i = 0; i < textInfo.length; i++)
                      Positioned(
                        left: textInfo[i].left,
                        top: textInfo[i].top,
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              currentIndex = i;
                              removeText(context);
                            });
                          },
                          onTap: () => setCurrentIndex(context, i),
                          child: Draggable(
                            feedback: ImageText(textInfo: textInfo[i]),
                            child: ImageText(textInfo: textInfo[i]),
                            onDragEnd: (drag) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              Offset off = renderBox.globalToLocal(drag.offset);
                              setState(() {
                                textInfo[i].top = off.dy - 94;
                                textInfo[i].left = off.dx;
                              });
                            },
                          ),
                        ),
                      ),
                    creatorText.text.isNotEmpty
                        ? Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(creatorText.text),
                          )
                        : const SizedBox.shrink()
                  ],
                )),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                isExtended: true,
                onPressed: () => addNewDialog(context),
                tooltip: 'Edit Image',
                label: const Text('Edit'),
                icon: const Icon(Icons.edit),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                isExtended: true,
                onPressed: () async {
                  XFile? file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) =>
                            EditImageFileScreen(selectedImage: file.path)));
                  }
                },
                tooltip: 'Retake Image',
                label: const Text('Retake'),
                icon: const Icon(Icons.camera),
              ),
            ],
          ),
        ),
      );
}
