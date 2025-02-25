import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/new_produto_form.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class NewProdutoScreen extends StatefulWidget {
  const NewProdutoScreen({super.key});

  @override
  State<NewProdutoScreen> createState() => _NewProdutoScreenState();
}

class _NewProdutoScreenState extends State<NewProdutoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiInstances.appBar,
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
