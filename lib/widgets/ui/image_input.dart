import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(
    this.pickedImage,
    this.setImageFile, {
    this.useCamera = true,
    super.key,
  });

  final File? pickedImage;
  final Function(File image) setImageFile;
  final bool useCamera;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void pickImage() async {
    final image = await ImagePicker().pickImage(
      source: widget.useCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (image == null) return;

    widget.setImageFile(File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: ColorTheme.primary,
          foregroundImage:
              widget.pickedImage != null
                  ? FileImage(widget.pickedImage!)
                  : null,
        ),
        TextButton.icon(
          onPressed: pickImage,
          label: Text('Adicionar foto', style: LetterTheme.secondaryTitle),
          icon: Icon(Icons.image),
        ),
      ],
    );
  }
}
