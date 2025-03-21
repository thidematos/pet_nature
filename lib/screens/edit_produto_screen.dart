import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/tab_provider.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/edit_produto_form.dart';
import 'package:pet_nature/widgets/ui/image_displayer.dart';
import 'package:pet_nature/widgets/ui/image_input.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class EditProdutoScreen extends ConsumerWidget {
  const EditProdutoScreen(this.produto, {super.key});

  final Map produto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: UiInstances.appBar(ref.read(TabProvider.notifier).goToProfile),
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              SizedBox(height: 40),
              PageTitle('Editar produto', subtitle: produto['name']),
              EditProdutoForm(produto),
            ],
          ),
        ),
      ),
    );
  }
}
