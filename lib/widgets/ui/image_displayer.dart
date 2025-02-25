import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageDisplayer extends StatelessWidget {
  const ImageDisplayer(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [UiInstances.shadow],
      ),
      child: FadeInImage(
        fit: BoxFit.contain,
        width: 125,
        height: 125,
        placeholder: MemoryImage(kTransparentImage),
        image: NetworkImage(url),
      ),
    );
  }
}
