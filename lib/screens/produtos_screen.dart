import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/screens/new_produto.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/expand_list.dart';
import 'package:pet_nature/widgets/ui/Search.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/expand_item.dart';
import 'package:pet_nature/widgets/ui/logo.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiInstances.logoToMainContentSpacer,
        PageTitle('Produtos cadastrados'),
        Search(placeholder: 'Pesquise o nome do produto desejado'),
        SizedBox(height: 20),
        Expanded(child: ExpandList()),
        Button('Novo produto', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewProduto()),
          );
        }),
      ],
    );
  }
}
