import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/image_displayer.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class EditProdutoScreen extends StatefulWidget {
  const EditProdutoScreen(this.produto, {super.key});

  final Map produto;

  @override
  State<EditProdutoScreen> createState() => _EditProdutoScreenState();
}

class _EditProdutoScreenState extends State<EditProdutoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiInstances.appBar,
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              SizedBox(height: 40),
              ImageDisplayer(widget.produto['image']!),
              PageTitle('Editar produto', subtitle: widget.produto['name']),
            ],
          ),
        ),
      ),
    );
  }
}
