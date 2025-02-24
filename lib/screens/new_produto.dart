import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class NewProduto extends StatefulWidget {
  const NewProduto({super.key});

  @override
  State<NewProduto> createState() => _NewProdutoState();
}

class _NewProdutoState extends State<NewProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiInstances.appBar,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
