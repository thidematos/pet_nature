import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/screens/edit_produto_screen.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/produtos/product_item.dart';
import 'package:pet_nature/widgets/produtos/produto_details_modal.dart';

class ExpandItem extends ConsumerWidget {
  const ExpandItem({required this.produtos, required this.title, super.key});

  final String title;
  final List produtos;

  void onClickDetails(BuildContext context, String role, curProduto) {
    print(role);
    if (appRoles.leitor.name == role) {
      showDialog(
        context: context,
        builder: (context) => ProdutoDetailsModal(curProduto),
      );
    }

    if (appRoles.estoquista.name == role || appRoles.admin.name == role) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => EditProdutoScreen()));
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

    if (produtos.isNotEmpty) {
      content = [
        for (final produto in produtos)
          InkWell(
            onTap: () {
              onClickDetails(context, curUserRole, produto);
            },
            child: ProductItem(produto['name']),
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
