import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/widgets/ui/input.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({this.label = 'Senha', super.key});

  final String label;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool useObscure = true;

  void toggleVisibility() {
    setState(() {
      useObscure = !useObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Input(
            placeholder: '*******',
            label: widget.label,
            useObscure: useObscure,
          ),
        ),
        Positioned(
          top: 50,
          right: 15,
          child: InkWell(
            splashColor: ColorTheme.light,
            onTap: toggleVisibility,
            child: Icon(
              useObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
