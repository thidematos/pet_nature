import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/providers/estoques_provider.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/fetched_estoques.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/loader.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class EstoqueScreen extends ConsumerStatefulWidget {
  const EstoqueScreen({super.key});

  @override
  ConsumerState<EstoqueScreen> createState() => _EstoqueScreenState();
}

class _EstoqueScreenState extends ConsumerState<EstoqueScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(EstoquesProvider);

    return data.when(
      data: (estoques) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UiInstances.logoToMainContentSpacer,
            PageTitle('Estoques'),
            FetchedEstoques(estoques),
          ],
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('Algo deu errado!', style: LetterTheme.secondaryTitle),
        );
      },
      loading: () => Loader(isPageLoader: true),
    );
  }
}
