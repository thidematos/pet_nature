import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(
    this.pickedImage,
    this.setImageFile, {
    this.radius = 40,
    this.useLastImage,
    this.useCamera = true,
    this.label = 'Adicionar foto',
    super.key,
  });

  final String label;
  final double radius;
  final String? useLastImage;
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
          radius: widget.radius,
          backgroundColor: ColorTheme.primary,
          foregroundImage:
              widget.pickedImage != null
                  ? FileImage(widget.pickedImage!)
                  : widget.useLastImage == null
                  ? null
                  : NetworkImage(widget.useLastImage!),
        ),
        TextButton.icon(
          onPressed: pickImage,
          label: Text(widget.label, style: LetterTheme.secondaryTitle),
          icon: Icon(Icons.image),
        ),
      ],
    );
  }
}
