import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/loader.dart';

class Button extends StatelessWidget {
  const Button(
    this.text,
    this.handler, {
    this.isLight = false,
    this.isLoading = false,
    super.key,
  });

  final String text;
  final void Function() handler;
  final bool isLight;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: isLight ? ColorTheme.light : ColorTheme.secondaryTwo,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [UiInstances.shadow],
        border:
            isLight
                ? Border.all(color: ColorTheme.secondaryTwo, width: 2)
                : null,
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 44),
      child: Center(
        child: InkWell(
          splashColor: ColorTheme.primary,
          enableFeedback: !isLoading,
          onTap: () {
            if (isLoading) return;
            handler();
          },
          child:
              isLoading
                  ? Loader()
                  : Text(
                    text,
                    style: LetterTheme.button.copyWith(
                      color:
                          isLight ? ColorTheme.secondaryTwo : ColorTheme.light,
                    ),
                  ),
        ),
      ),
    );
  }
}
