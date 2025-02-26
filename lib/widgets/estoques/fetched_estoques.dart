import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/estoques/new_estoque.dart';
import 'package:pet_nature/widgets/ui/button.dart';

class FetchedEstoques extends StatelessWidget {
  const FetchedEstoques(this.estoques, {super.key});

  final estoques;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (estoques.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não há registro de estoques!',
                  style: LetterTheme.secondaryTitle.copyWith(
                    color: ColorTheme.danger,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          Spacer(),
          Row(
            spacing: 16,
            children: [
              Flexible(
                flex: 1,
                child: Button('Cadastrar no estoque', () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => NewEstoque()));
                }),
              ),
              Flexible(flex: 1, child: Button('Registrar baixa', () {})),
            ],
          ),
        ],
      ),
    );
  }
}
