import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/produtos_provider.dart';
import 'package:pet_nature/widgets/ui/expand_item.dart';

final Map<String, String> kProdutosTypes = {
  'alimentos-umidos': 'Alimentos úmidos (latas e sachês)',
  'camas-almofadas': 'Camas e almofadas',
  'coleiras-guias': 'Coleiras e guias',
  'escovas-pentes': 'Escovas e pentes',
  'racao': 'Ração',
  'shampoo-cond': 'Shampoo e condicionadores',
};

class ExpandList extends StatelessWidget {
  const ExpandList(this.produtos, {super.key});

  final List produtos;

  List getTypeProdutos(String type) {
    return produtos.where((produto) => produto['type'] == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final type in kProdutosTypes.keys)
            if (getTypeProdutos(type).isNotEmpty)
              ExpandItem(
                items: [for (final item in getTypeProdutos(type)) item['name']],
                title: kProdutosTypes[type]!,
              ),
        ],
      ),
    );
  }
}
