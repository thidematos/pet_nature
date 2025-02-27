import 'package:flutter/material.dart';

class RegistrarBaixaForm extends StatefulWidget {
  const RegistrarBaixaForm({super.key});

  @override
  State<RegistrarBaixaForm> createState() => _RegistrarBaixaFormState();
}

class _RegistrarBaixaFormState extends State<RegistrarBaixaForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            InkWell(
              child: Row(
                children: [
                  Icon(Icons.qr_code_scanner),
                  Text('Scannear o código de barras do produto'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
