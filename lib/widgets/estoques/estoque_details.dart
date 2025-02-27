import 'package:flutter/material.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/produtos/detail_row.dart';
import 'package:pet_nature/widgets/ui/image_displayer.dart';

class EstoqueDetails extends StatefulWidget {
  const EstoqueDetails(this.estoque, {super.key});

  final estoque;

  @override
  State<EstoqueDetails> createState() => _EstoqueDetailsState();
}

class _EstoqueDetailsState extends State<EstoqueDetails> {
  bool isLoading = false;
  Map? user;

  void getLastEditionUser() async {
    setState(() {
      isLoading = true;
    });

    user = await FirebaseFirestoreApi.getUser(
      widget.estoque['last_edition']['user'],
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
            ImageDisplayer(widget.estoque['produto']['image']),
            Text(
              widget.estoque['produto']['name'],
              style: LetterTheme.secondaryTitle.copyWith(
                color: ColorTheme.secondaryTwo,
              ),
            ),
            DetailRow('Marca:', widget.estoque['produto']['brand']),
            DetailRow('Lote:', widget.estoque['lote'].toString()),
            DetailRow('Quantidade:', widget.estoque['qtd'].toString()),
            DetailRow(
              'Data de validade:',
              kFormatTimestamp(widget.estoque['expires_in']),
            ),
            DetailRow(
              'Data de cadastro:',
              kFormatTimestamp(widget.estoque['created_at']),
            ),
            DetailRow(
              'Última edição:',
              kFormatTimestamp(widget.estoque['last_edition']['timestamp']),
            ),
            DetailRow('Usuário que editou:', user!['code']),
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
