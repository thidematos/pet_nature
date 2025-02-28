import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/screens/registrar_baixa_screen.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/estoques/expand_estoque_list.dart';
import 'package:pet_nature/screens/new_estoque_screen.dart';
import 'package:pet_nature/widgets/ui/button.dart';

class FetchedEstoques extends ConsumerWidget {
  const FetchedEstoques(this.estoques, {super.key});

  final List estoques;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.read(UserProvider.notifier).role;

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
          if (estoques.isNotEmpty) Expanded(child: ExpandEstoqueList(estoques)),
          if (estoques.isEmpty) Spacer(),
          if (role == kAppRoles.admin.name || role == kAppRoles.estoquista.name)
            Row(
              spacing: 16,
              children: [
                Flexible(
                  flex: 1,
                  child: Button('Novo estoque', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewEstoqueScreen(),
                      ),
                    );
                  }),
                ),
                if (estoques.isNotEmpty)
                  Flexible(
                    flex: 1,
                    child: Button('Registrar baixa', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegistrarBaixaScreen(),
                        ),
                      );
                    }, isDanger: true),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
