import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/estoques_provider.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/input_date.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/confirm_password.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class EditEstoqueScreen extends ConsumerStatefulWidget {
  const EditEstoqueScreen(this.estoque, {super.key});

  final Map estoque;

  @override
  ConsumerState<EditEstoqueScreen> createState() => _EditEstoqueScreenState();
}

class _EditEstoqueScreenState extends ConsumerState<EditEstoqueScreen> {
  int? timestamp;
  TextEditingController? qtdController;
  TextEditingController? loteController;

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  void onSelectTimestamp(int selectedTimestamp) {
    timestamp = selectedTimestamp;
  }

  void deleteEstoque() async {
    final isConfirmed = await showDialog(
      context: context,
      builder: (context) => ConfirmPassword('Deletar estoque'),
    );

    if (!isConfirmed) return;

    setState(() {
      isLoading = true;
    });

    await FirebaseFirestoreApi.deleteEstoque(context, widget.estoque['uid']);

    setState(() {
      isLoading = false;
    });

    ref.invalidate(EstoquesProvider);
    Navigator.of(context).pop();
  }

  void submit() async {
    final bool isValidated = formKey.currentState!.validate();

    if (!isValidated) return;

    if (timestamp == null) {
      UiInstances.showSnackbar(context, 'Validade inválida!');
      return;
    }

    final estoqueData = {
      'qtd': int.parse(qtdController!.text),
      'lote': int.parse(loteController!.text),
      'expires_in': timestamp,
      'last_edition': {
        'user': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    };

    setState(() {
      isLoading = true;
    });

    await FirebaseFirestoreApi.updateEstoque(
      context,
      estoqueData,
      widget.estoque['uid'],
    );

    setState(() {
      isLoading = false;
    });

    ref.invalidate(EstoquesProvider);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    timestamp = widget.estoque['expires_in'];
    qtdController = TextEditingController(
      text: widget.estoque['qtd'].toString(),
    );
    loteController = TextEditingController(
      text: widget.estoque['lote'].toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String curDate = kFormatTimestamp(widget.estoque['expires_in']);

    return Scaffold(
      appBar: UiInstances.appBar(),
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 16,
              children: [
                UiInstances.logoToMainContentSpacer,
                PageTitle('Editar estoque', subtitle: widget.estoque['name']),
                Input(
                  placeholder: '12345678',
                  label: 'Lote*',
                  useNumberKeyboard: true,
                  controller: loteController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        value.length < 6) {
                      return 'Lote inválido!';
                    }

                    return null;
                  },
                ),
                Row(
                  spacing: 16,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Input(
                        placeholder: '32',
                        label: 'Qtd.*',
                        useNumberKeyboard: true,
                        controller: qtdController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.parse(value) < 1) {
                            return 'Qtd. inválida!';
                          }

                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: InputDate(
                        timestamp,
                        onSelectTimestamp,
                        label: 'Data de validade*',
                        useCurrentDate: curDate,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  spacing: 16,
                  children: [
                    Flexible(
                      child: Button(
                        'Salvar estoque',
                        submit,
                        isLoading: isLoading,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Button(
                        'Excluir',
                        deleteEstoque,
                        isDanger: true,
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
