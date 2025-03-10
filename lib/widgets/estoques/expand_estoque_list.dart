import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/providers/produtos_provider.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/estoques/expand_estoque_item.dart';
import 'package:pet_nature/widgets/ui/loader.dart';

class ExpandEstoqueList extends ConsumerWidget {
  const ExpandEstoqueList(this.estoques, {super.key});

  final List estoques;

  List getProdutosEstocados(List populatedEstoques, String category) {
    return populatedEstoques
        .where((estoque) => estoque['produto']['category'] == category)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.read(ProdutosProvider);

    return data.when(
      data: (produtos) {
        final populatedEstoques =
            estoques.map((estoque) {
              final curProduto =
                  produtos
                      .where((produto) => produto['uid'] == estoque['produto'])
                      .toList()[0];

              final curEstoqueWithProduto = {...estoque, 'produto': curProduto};

              return curEstoqueWithProduto;
            }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              for (final category in kProdutosCategories.keys)
                if (getProdutosEstocados(
                  populatedEstoques,
                  category,
                ).isNotEmpty)
                  ExpandEstoqueItem(
                    estoques: getProdutosEstocados(populatedEstoques, category),
                    title: kProdutosCategories[category]!,
                  ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('Algo deu errado!', style: LetterTheme.secondaryTitle),
        );
      },
      loading: () => Loader(isPageLoader: true),
    );
  }
}
