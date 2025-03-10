import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pet_nature/providers/estoques_provider.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/services/firebase_auth_api.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/barcode_scanner.dart';
import 'package:pet_nature/widgets/estoques/input_date.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/confirm_password.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/loader.dart';

class RegistrarBaixaForm extends ConsumerStatefulWidget {
  const RegistrarBaixaForm({super.key});

  @override
  ConsumerState<RegistrarBaixaForm> createState() => _RegistrarBaixaFormState();
}

class _RegistrarBaixaFormState extends ConsumerState<RegistrarBaixaForm> {
  String selectedEstoqueUid = '';
  Map? selectedEstoque;
  int? timestamp;
  final TextEditingController qtdController = TextEditingController(text: '');

  bool isLoading = false;

  void onSelectTimestamp(int selectedTimestamp) {
    setState(() {
      timestamp = selectedTimestamp;
    });
  }

  void onDetectedBarcode(List estoques, String detectedCode) {
    setState(() {
      selectedEstoque =
          estoques
              .where(
                (estoque) => estoque['uid'].toString().startsWith(detectedCode),
              )
              .toList()[0];

      selectedEstoqueUid = selectedEstoque!['uid'];
    });
  }

  void submit() async {
    final int? parsedQtd = int.tryParse(qtdController.text);

    if (timestamp == null ||
        selectedEstoqueUid.isEmpty ||
        selectedEstoque == null ||
        qtdController.text.isEmpty ||
        parsedQtd! < 1) {
      UiInstances.showSnackbar(
        context,
        'Por favor, preencha todos os campos corretamente',
      );

      setState(() {
        selectedEstoque = null;
        selectedEstoqueUid = '';
      });
      return;
    }

    final int newEstoqueQtd = selectedEstoque!['qtd'] - parsedQtd;

    if (newEstoqueQtd < 0) {
      UiInstances.showSnackbar(
        context,
        'Qtd. de baixa menor que o disponível no estoque!',
      );
      return;
    }

    final String? isConfirmed = await showDialog(
      context: context,
      builder: (context) => ConfirmPassword('Registrar baixa'),
    );

    if (isConfirmed == null) return;

    setState(() {
      isLoading = true;
    });

    if (newEstoqueQtd == 0) {
      await FirebaseFirestoreApi.deleteEstoque(context, selectedEstoqueUid);
      ref.invalidate(EstoquesProvider);
      UiInstances.showSnackbar(context, 'Estoque zerado e excluído!');
      return Navigator.of(context).pop();
    }

    final baixaData = {
      'registered_at': timestamp,
      'estoque': selectedEstoqueUid,
      'qtd': parsedQtd,
      'user': FirebaseAuth.instance.currentUser!.uid,
      'uid': kUuid.v4(),
    };

    await FirebaseFirestoreApi.createBaixa(context, baixaData);
    await FirebaseFirestoreApi.registerBaixa(selectedEstoqueUid, newEstoqueQtd);

    setState(() {
      isLoading = false;
    });

    ref.invalidate(EstoquesProvider);
    Navigator.of(context).pop();

    return;
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(EstoquesProvider);

    return data.when(
      data: (estoques) {
        return Column(
          spacing: 16,
          children: [
            InkWell(
              onTap: () async {
                String detectedCode = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BarcodeScanner()),
                );

                onDetectedBarcode(estoques, detectedCode);
              },
              splashColor: const Color.fromARGB(43, 163, 163, 163),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_scanner),
                    Text('Scannear o código de barras do produto'),
                  ],
                ),
              ),
            ),
            Text(
              selectedEstoque == null ? '' : selectedEstoque!['name'],
              style: LetterTheme.mainTitle,
            ),
            if (selectedEstoque != null)
              Text('Quantidade em estoque: ${selectedEstoque!['qtd']}'),
            Row(
              spacing: 16,
              children: [
                Flexible(
                  flex: 1,
                  child: Input(
                    placeholder: '8',
                    label: 'Qtd.*',
                    useNumberKeyboard: true,
                    controller: qtdController,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: InputDate(
                    timestamp,
                    onSelectTimestamp,
                    label: 'Data da baixa*',
                    useBackwards: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Button(
                    'Registrar baixa',
                    submit,
                    isLoading: isLoading,
                    isDanger: true,
                  ),
                ),
                Flexible(flex: 1, child: SizedBox()),
              ],
            ),
          ],
        );
      },
      error:
          (error, stackTrace) => Center(
            child: Text(
              'Algo deu errado.',
              style: LetterTheme.secondaryTitle.copyWith(
                color: ColorTheme.danger,
              ),
            ),
          ),
      loading: () => Center(child: Loader()),
    );
  }
}
