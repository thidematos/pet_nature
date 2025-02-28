import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({
    required this.query,
    required this.onQuery,
    required this.placeholder,
    this.useNumberKeyboard = false,
    super.key,
  });

  final bool useNumberKeyboard;
  final Function(String value) onQuery;
  final String query;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          useNumberKeyboard ? TextInputType.number : TextInputType.text,
      onChanged: (value) => onQuery(value),
      decoration: InputDecoration().copyWith(
        hintText: placeholder,
        suffixIcon: Icon(Icons.search, size: 32),
      ),
    );
  }
}
