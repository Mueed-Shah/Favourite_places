import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {

  const ImageInput({super.key,required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void takePicture() async {
  final imagePicker =ImagePicker();
  final saveImage =await imagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);
  if(saveImage == null){
    return;
  }
  setState(() {
    _selectedImage = File(saveImage.path);
  });
 widget.onPickImage(_selectedImage!);

  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: takePicture,
        icon: const Icon(Icons.camera),
        label: const Text('Take picture'));
    if(_selectedImage != null){
      content = GestureDetector(
        onTap: takePicture,
        child: Image.file(_selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity
        ),
      );
    }
    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1))),
        alignment: Alignment.center,
        child: content);
  }
}
