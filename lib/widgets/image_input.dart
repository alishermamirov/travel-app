import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as systemPath;
import 'package:path/path.dart' as path;

import 'dart:io';

class ImageInput extends StatefulWidget {
  final Function takeSaveImage;
  const ImageInput({
    super.key,
    required this.takeSaveImage,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (photo != null) {
      setState(() {
        // _imageFile = photo as File;
        _imageFile = File(photo.path);
      });
      final pathProvider = await systemPath.getApplicationDocumentsDirectory();
      final fileName = path.basename(photo.path);
      final savedImage =
          await _imageFile!.copy("${pathProvider.path}/$fileName");

      widget.takeSaveImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.teal,
            ),
          ),
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text("Rasm yo'q"),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _takePicture();
            });
          },
          icon: const Icon(Icons.camera),
          label: const Text("Rasm yuklash"),
        ),
      ],
    );
  }
}
