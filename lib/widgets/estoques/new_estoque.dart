import 'package:flutter/material.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/estoques/input_date.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/dropdown.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/loader.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class NewEstoque extends StatefulWidget {
  const NewEstoque({super.key});

  @override
  State<NewEstoque> createState() => _NewEstoqueState();
}

class _NewEstoqueState extends State<NewEstoque> {
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
  void submit() async {}

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
      appBar: UiInstances.appBar,
      body: Padding(
        padding: UiInstances.screenPaddingWithAppBar,
        child: SingleChildScrollView(
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
                  : Form(
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
                          useNumberKeyboard: true,
                        ),
                        Row(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Input(
                                placeholder: '32',
                                label: 'Quantidade*',
                                useNumberKeyboard: true,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: InputDate(timestamp, onSelectTimestamp),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Button('Criar estoque', () {}),
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
