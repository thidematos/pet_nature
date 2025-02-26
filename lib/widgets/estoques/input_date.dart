import 'package:flutter/material.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class InputDate extends StatefulWidget {
  const InputDate(this.timetamp, this.timestampSetter, {super.key});

  final int? timetamp;
  final void Function(int timestamp) timestampSetter;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  String date = '--/--/----';

  void onChooseDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      confirmText: 'Escolher',
      cancelText: 'Cancelar',
      lastDate: DateTime.now().add(Duration(days: 2000)),
    );

    if (pickedDate == null) return;

    setState(() {
      date = kFormatTimestamp(pickedDate.millisecondsSinceEpoch.toString());
      widget.timestampSetter(pickedDate.millisecondsSinceEpoch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(
          'Data de validade*',
          style: LetterTheme.secondaryTitle,
          textAlign: TextAlign.start,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorTheme.dark, width: 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [UiInstances.shadow],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(date),
              IconButton(
                onPressed: onChooseDate,
                icon: Icon(Icons.calendar_month),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
