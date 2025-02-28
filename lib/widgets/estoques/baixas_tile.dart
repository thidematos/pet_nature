import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class BaixasTile extends StatefulWidget {
  const BaixasTile(this.estoques, this.baixa, {super.key});

  final List estoques;
  final Map baixa;

  @override
  State<BaixasTile> createState() => _BaixasTileState();
}

class _BaixasTileState extends State<BaixasTile> {
  Map? user;
  bool isLoading = true;

  void getUser() async {
    user = await FirebaseFirestoreApi.getUser(widget.baixa['user']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final curEstoque =
        widget.estoques
            .where((estoque) => estoque['uid'] == widget.baixa['estoque'])
            .toList()[0];

    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: ColorTheme.primaryTwo, width: 1),
        ),
      ),
      child: ListTile(
        title: Text(curEstoque['name']),

        isThreeLine: true,
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      spacing: 8,
                      children: [
                        Text(
                          'Lote:',
                          style: LetterTheme.textSemibold.copyWith(
                            color: ColorTheme.secondaryTwo,
                          ),
                        ),
                        Text(
                          curEstoque['lote'].toString(),
                          style: LetterTheme.text.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      spacing: 8,
                      children: [
                        Text(
                          'Qtd. retirada:',
                          style: LetterTheme.textSemibold.copyWith(
                            color: ColorTheme.secondaryTwo,
                          ),
                        ),
                        Text(
                          widget.baixa['qtd'].toString(),
                          style: LetterTheme.text.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Row(
                      spacing: 8,
                      children: [Icon(Icons.person), Text(user!['code'])],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(Icons.calendar_month),
                        Text(kFormatTimestamp(widget.baixa['registered_at'])),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
