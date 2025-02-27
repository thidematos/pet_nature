import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/screens/edit_estoque_screen.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/estoques/estoque_details.dart';
import 'package:pet_nature/widgets/produtos/product_item.dart';
import 'package:pet_nature/widgets/produtos/produto_details_modal.dart';

class ExpandEstoqueItem extends ConsumerWidget {
  const ExpandEstoqueItem({
    required this.estoques,
    required this.title,
    super.key,
  });

  final String title;
  final List estoques;

  void onClickDetails(BuildContext context, String role, curEstoque) {
    print(role);
    if (kAppRoles.leitor.name == role) {
      showDialog(
        context: context,
        builder: (context) => EstoqueDetails(curEstoque),
      );
    }

    if (kAppRoles.estoquista.name == role || kAppRoles.admin.name == role) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditEstoqueScreen(curEstoque)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUserRole = ref.read(UserProvider.notifier).role;

    List<Widget> content = [
      ListTile(
        title: Text(
          'Não há produtos dessa categoria!',
          style: LetterTheme.textSemibold,
        ),
      ),
    ];

    if (estoques.isNotEmpty) {
      content = [
        for (final estoque in estoques)
          InkWell(
            onTap: () {
              onClickDetails(context, curUserRole, estoque);
            },
            child: Column(
              children: [
                ProductItem(estoque['produto']['name']),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Row(
                    children: [
                      FittedBox(
                        child: Text(
                          'Lote: ${estoque['lote'].toString()}',
                          style: LetterTheme.textSemibold,
                        ),
                      ),
                      SizedBox(width: 40),
                      FittedBox(
                        child: Text(
                          'Quantidade: ${estoque['qtd'].toString()}',
                          style: LetterTheme.textSemibold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ];
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 8),
      title: Text(title, style: LetterTheme.secondaryTitle),
      children: content,
    );
  }
}
