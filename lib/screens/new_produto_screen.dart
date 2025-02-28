import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/tab_provider.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/new_produto_form.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class NewProdutoScreen extends ConsumerStatefulWidget {
  const NewProdutoScreen({super.key});

  @override
  ConsumerState<NewProdutoScreen> createState() => _NewProdutoScreenState();
}

class _NewProdutoScreenState extends ConsumerState<NewProdutoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiInstances.appBar(ref.read(TabProvider.notifier).goToProfile),
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              PageTitle('Novo produto'),
              NewProdutoForm(),
            ],
          ),
        ),
      ),
    );
  }
}
