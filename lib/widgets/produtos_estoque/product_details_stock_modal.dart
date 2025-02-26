import 'package:flutter/material.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/detail_row.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/image_displayer.dart';

class ProdutoDetailsStockModal extends StatefulWidget {
  const ProdutoDetailsStockModal(this.produto, {super.key});

  final Map produto;

  @override
  State<ProdutoDetailsStockModal> createState() => _ProdutoDetailsStockModalState();
}

class _ProdutoDetailsStockModalState extends State<ProdutoDetailsStockModal> {
  bool isLoading = false;
  Map? user;

  void getLastEditionUser() async {
    setState(() {
      isLoading = true;
    });

    user = await FirebaseFirestoreApi.getUser(
      widget.produto['last_edition']['user'],
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getLastEditionUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? content;

    if (isLoading) {
      content = FractionallySizedBox(
        heightFactor: 0.6,
        child: Center(
          child: CircularProgressIndicator(color: ColorTheme.secondaryTwo),
        ),
      );
    }

    if (!isLoading) {
      content = SingleChildScrollView(
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageDisplayer(widget.produto['image']),
            Text(
              widget.produto['name'],
              style: LetterTheme.secondaryTitle.copyWith(
                color: ColorTheme.secondaryTwo,
              ),
            ),
            DetailRow(
              'Tipo:',
              kProdutosCategories[widget.produto['category']]!,
            ),
            DetailRow('Marca:', widget.produto['brand']),
            DetailRow('Lote:', widget.produto['lote']),
            DetailRow(
              'Quantidade em estoque:',
              widget.produto['stock'].toString(),
            ), 
            DetailRow(
              'Data de cadastro:',
              kFormatTimestamp(widget.produto['created_at']),
            ),
            DetailRow(
              'Última edição:',
              kFormatTimestamp(widget.produto['last_edition']['timestamp']),
            ),
            DetailRow('Usuário que editou:', user!['code']),
            DetailRow(
              'Descrição:',
              (widget.produto['description'] as String).isEmpty
                  ? 'Sem descrição'
                  : widget.produto['description'],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Fechar',
                    style: LetterTheme.secondaryTitle.copyWith(
                      color: ColorTheme.danger,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Dialog(
      backgroundColor: ColorTheme.light,
      child: Padding(padding: UiInstances.modalPadding, child: content),
    );
  }
}
