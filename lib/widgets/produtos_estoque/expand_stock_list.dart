import 'package:flutter/material.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/widgets/produtos/expand_item.dart';
import 'package:pet_nature/widgets/produtos_estoque/expand_stock_item.dart';

class ExpandStockList extends StatelessWidget {
  const ExpandStockList(this.produtos, {super.key});

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
              ExpandStockItem(
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
