import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/screens/new_stock_product_screen.dart';
import 'package:pet_nature/widgets/produtos/expand_list.dart';
import 'package:pet_nature/widgets/produtos/no_produtos.dart';
import 'package:pet_nature/widgets/ui/search.dart';
import 'package:pet_nature/widgets/ui/button.dart';

class FetchedStockProdutos extends ConsumerStatefulWidget {
  const FetchedStockProdutos(this.produtosstock, {super.key});

  final List produtosstock;

  @override
  ConsumerState<FetchedStockProdutos> createState() => _FetchedProdutosState();
}

class _FetchedProdutosState extends ConsumerState<FetchedStockProdutos> {
  String query = '';

  void onQuery(String value) {
    setState(() {
      query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.read(UserProvider.notifier).role;

    final filteredProdutos =
        widget.produtosstock.where((produtostock) {
          if (query.isEmpty) return true;

          final cleanProductName = removeDiacritics(
            produtostock['name'].toLowerCase(),
          );
          final cleandQuery = removeDiacritics(query.toLowerCase());

          return cleanProductName.contains(cleandQuery) ? true : false;
        }).toList();

    return Expanded(
      child: Column(
        children: [
          Search(
            onQuery: onQuery,
            query: query,
            placeholder: 'Pesquise o nome do produto desejado',
          ),
          SizedBox(height: 20),
          if (filteredProdutos.isEmpty) NoProdutos(),
          if (filteredProdutos.isNotEmpty)
            Expanded(child: ExpandList(filteredProdutos)),
          if (role == 'admin' || role == 'estoquista')
            Button('Novo produto', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewStockProductScreen()),
              );
            }),
        ],
      ),
    );
  }
}
