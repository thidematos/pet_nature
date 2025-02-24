import 'package:flutter/material.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/produtos/product_item.dart';

class ExpandItem extends StatefulWidget {
  const ExpandItem({required this.items, required this.title, super.key});

  final String title;
  final List items;

  @override
  State<ExpandItem> createState() => _ExpandItemState();
}

class _ExpandItemState extends State<ExpandItem> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      ListTile(
        title: Text(
          'Não há produtos dessa categoria!',
          style: LetterTheme.textSemibold,
        ),
      ),
    ];

    if (widget.items.isNotEmpty) {
      content = [for (final item in widget.items) ProductItem(item)];
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 8),
      title: Text(widget.title, style: LetterTheme.secondaryTitle),
      children: content,
    );
  }
}
