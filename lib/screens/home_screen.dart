import 'package:basic_image_editor/screens/edit_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
        child: IconButton(
            onPressed: () async {
              XFile? file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) =>
                        EditImageFileScreen(selectedImage: file.path)));
              }
            },
            icon: const Icon(Icons.upload_file)),
      ));
}
