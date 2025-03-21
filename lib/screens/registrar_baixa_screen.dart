import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/tab_provider.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/registrar_baixa_form.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class RegistrarBaixaScreen extends ConsumerWidget {
  const RegistrarBaixaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: UiInstances.appBar(ref.read(TabProvider.notifier).goToProfile),
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child: SingleChildScrollView(
          child: Column(
            children: [
              UiInstances.logoToMainContentSpacer,
              PageTitle('Registrar baixa no estoque'),
              RegistrarBaixaForm(),
            ],
          ),
        ),
      ),
    );
  }
}
