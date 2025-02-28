import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/estoques_provider.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/providers/tab_provider.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/input_date.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/dropdown.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class NewEstoqueScreen extends ConsumerStatefulWidget {
  const NewEstoqueScreen({super.key});

  @override
  ConsumerState<NewEstoqueScreen> createState() => _NewEstoqueScreenState();
}

class _NewEstoqueScreenState extends ConsumerState<NewEstoqueScreen> {
  List produtos = [];
  bool isLoading = true;
  String selectedProduto = '';
  final TextEditingController loteController = TextEditingController(text: '');
  final TextEditingController qtdController = TextEditingController(text: '');
  int? timestamp;

  final formKey = GlobalKey<FormState>();

  void getProdutos() async {
    produtos = await FirebaseFirestoreApi.getProdutos();

    setState(() {
      isLoading = false;
    });
  }

  void onSelectTimestamp(int selectedTimestamp) {
    timestamp = selectedTimestamp;
  }

  void onSelectProduto(String produtoUid) async {
    setState(() {
      selectedProduto = produtoUid;
    });
  }

  //TO DO -> VALIDATORS AND SUBMIT FUNCTION
  void submit() async {
    final isValidated = formKey.currentState!.validate();
    if (!isValidated) return;

    if (timestamp == null) {
      UiInstances.showSnackbar(context, 'Validade inválida');
      return;
    }

    final estoqueData = {
      'produto': selectedProduto,
      'name':
          produtos
              .where((produto) => produto['uid'] == selectedProduto)
              .toList()[0]['name'],
      'lote': int.tryParse(loteController.text),
      'qtd': int.tryParse(qtdController.text),
      'expires_in': timestamp,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'last_edition': {
        'user': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      'uid': kUuid.v4(),
    };

    setState(() {
      isLoading = true;
    });

    final isOkay = await FirebaseFirestoreApi.createEstoque(
      context,
      estoqueData,
    );

    setState(() {
      isLoading = false;
    });

    if (isOkay == false) {
      return;
    }

    Navigator.of(context).pop();
    ref.invalidate(EstoquesProvider);
  }

  @override
  void initState() {
    getProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedProduto.isEmpty && produtos.isNotEmpty) {
      selectedProduto = produtos[0]['uid'];
    }

    return Scaffold(
      appBar: UiInstances.appBar(ref.read(TabProvider.notifier).goToProfile),
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child:
            isLoading
                ? Center(
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: CircularProgressIndicator(
                      color: ColorTheme.secondaryTwo,
                    ),
                  ),
                )
                : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 16,
                      children: [
                        UiInstances.logoToMainContentSpacer,
                        PageTitle('Cadastrar produto no estoque'),
                        Dropdown(
                          'Produtos',
                          items: {},
                          defaultValue: selectedProduto,
                          onChange: onSelectProduto,
                          useArray: true,
                          itemsArr: produtos,
                        ),
                        Input(
                          placeholder: '12341234',
                          label: 'Lote*',
                          controller: loteController,
                          useNumberKeyboard: true,
                          validator: (value) {
                            if (value == null ||
                                value.length < 6 ||
                                int.tryParse(value) == null) {
                              return 'Insira um lote válido!';
                            }

                            return null;
                          },
                        ),
                        Row(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Input(
                                placeholder: '32',
                                label: 'Qtd.*',
                                controller: qtdController,
                                useNumberKeyboard: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      int.tryParse(value) == null ||
                                      int.tryParse(value)! < 1) {
                                    return 'Qtd. Inválida!';
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
                                useCurrentDate: '',
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
                                'Criar estoque',
                                submit,
                                isLoading: isLoading,
                              ),
                            ),
                            Flexible(flex: 1, child: SizedBox()),
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
