import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/registrar_baixa_form.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class RegistrarBaixaScreen extends StatelessWidget {
  const RegistrarBaixaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiInstances.appBar(),
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
