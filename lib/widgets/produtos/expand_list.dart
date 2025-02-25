import 'package:flutter/material.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/widgets/ui/expand_item.dart';

class ExpandList extends StatelessWidget {
  const ExpandList(this.produtos, {super.key});

  final List produtos;

  List getCategoryProdutos(String category) {
    return produtos
        .where((produto) => produto['category'] == category)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final category in kProdutosCategories.keys)
            if (getCategoryProdutos(category).isNotEmpty)
              ExpandItem(
                produtos: [
                  for (final produto in getCategoryProdutos(category)) produto,
                ],
                title: kProdutosCategories[category]!,
              ),
        ],
      ),
    );
  }
}
