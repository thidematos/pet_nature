import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class Input extends StatelessWidget {
  const Input({
    required this.placeholder,
    required this.label,
    this.validator,
    this.useAutoCapitalization = false,
    this.keyToSave = '',
    this.onSave,
    this.controller,
    this.useObscure = false,
    this.useNumberKeyboard = false,
    this.minLines,
    this.readOnly,

    super.key,
  });

  final bool? readOnly;
  final bool useNumberKeyboard;
  final int? minLines;
  final String placeholder;
  final String label;
  final bool useObscure;
  final bool useAutoCapitalization;
  final Function(String? value)? validator;
  final Function(String key, String value)? onSave;
  final String keyToSave;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(
          label,
          style: LetterTheme.secondaryTitle,
          textAlign: TextAlign.start,
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorTheme.light,
            boxShadow: [UiInstances.shadow],
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly ?? false,
            keyboardType:
                useNumberKeyboard ? TextInputType.number : TextInputType.text,
            onSaved:
                (value) => {if (onSave != null) onSave!(keyToSave, value!)},
            validator: (value) {
              if (validator == null) return null;

              return validator!(value);
            },
            textCapitalization:
                useAutoCapitalization
                    ? TextCapitalization.sentences
                    : TextCapitalization.none,
            obscureText: useObscure,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: LetterTheme.placeholder,
            ),
          ),
        ),
      ],
    );
  }
}
