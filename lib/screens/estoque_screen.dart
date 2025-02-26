import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/produtos_provider.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/fetched_produtos.dart';
import 'package:pet_nature/widgets/produtos_estoque/fetched_stock_products.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class EstoqueScreen extends ConsumerWidget {
  const EstoqueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ProdutosProvider);

    return data.when(
      data: (produtosstock) {
        return Column(
          children: [
            UiInstances.logoToMainContentSpacer,
            PageTitle('Estoque'),
            FetchedStockProducts(produtosstock),
          ],
        );
      },
      error: (err, stack) {
        UiInstances.showSnackbar(context, (err as FirebaseException).message!);
        return Text('Algo deu errado');
      },
      loading:
          () => Column(
            children: [
              UiInstances.logoToMainContentSpacer,
              PageTitle('Produtos cadastrados'),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: CircularProgressIndicator(
                      color: ColorTheme.secondaryTwo,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
