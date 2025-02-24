import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/screens/new_produto.dart';
import 'package:pet_nature/widgets/produtos/expand_list.dart';
import 'package:pet_nature/widgets/produtos/no_produtos.dart';
import 'package:pet_nature/widgets/ui/Search.dart';
import 'package:pet_nature/widgets/ui/button.dart';

class FetchedProdutos extends StatefulWidget {
  const FetchedProdutos(this.produtos, {super.key});

  final List produtos;

  @override
  State<FetchedProdutos> createState() => _FetchedProdutosState();
}

class _FetchedProdutosState extends State<FetchedProdutos> {
  String query = '';

  void onQuery(String value) {
    setState(() {
      query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProdutos =
        widget.produtos.where((produto) {
          if (query.isEmpty) return true;

          final cleanProductName = removeDiacritics(
            produto['name'].toLowerCase(),
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
          Button('Novo produto', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProduto()),
            );
          }),
        ],
      ),
    );
  }
}
