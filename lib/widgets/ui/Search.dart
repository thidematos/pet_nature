import 'package:flutter/material.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class Search extends StatefulWidget {
  const Search({required this.placeholder, super.key});

  final String placeholder;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration().copyWith(
        hintText: widget.placeholder,
        suffixIcon: Icon(Icons.search, size: 32),
      ),
    );
  }
}
