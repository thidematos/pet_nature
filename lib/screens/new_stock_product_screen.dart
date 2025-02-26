import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos_estoque/new_stock_product_form.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class NewStockProductScreen extends StatefulWidget {
  const NewStockProductScreen({super.key});

  @override
  State<NewStockProductScreen> createState() => _NewProdutoScreenState();
}

class _NewProdutoScreenState extends State<NewStockProductScreen> {
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
              NewStockProductForm(),
            ],
          ),
        ),
      ),
    );
  }
}
