import 'package:flutter/material.dart';
import 'package:pet_nature/widgets/ui/expand_item.dart';

class ExpandList extends StatelessWidget {
  const ExpandList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpandItem(
            items: [
              'Sachê Para Cães Adultos Pequeno Porte',
              'Ração Úmida Sachê Magnus Sabor Carne',
              'Sachê Natural Carnilove Premium Faisão ',
            ],
            title: 'Alimentos úmidos (latas e sachês)',
          ),
          ExpandItem(
            items: [
              'This is a placeholder',
              'This is a placeholder',
              'This also is a placeholder',
            ],
            title: 'Camas e almofadas',
          ),
          ExpandItem(
            items: [
              'This is a placeholder',
              'This is a placeholder',
              'This also is a placeholder',
            ],
            title: 'Coleiras e guias',
          ),
          ExpandItem(
            items: [
              'This is a placeholder',
              'This is a placeholder',
              'This also is a placeholder',
            ],
            title: 'Escovas e pentes',
          ),
          ExpandItem(
            items: [
              'This is a placeholder',
              'This is a placeholder',
              'This also is a placeholder',
            ],
            title: 'Ração',
          ),
          ExpandItem(
            items: [
              'This is a placeholder',
              'This is a placeholder',
              'This also is a placeholder',
            ],
            title: 'Shampoo e condicionadores',
          ),
        ],
      ),
    );
  }
}
