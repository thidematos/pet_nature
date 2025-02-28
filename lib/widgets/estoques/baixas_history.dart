import 'package:flutter/material.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/services/firebase_storage_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/estoques/baixas_tile.dart';
import 'package:pet_nature/widgets/ui/loader.dart';

class BaixasHistory extends StatefulWidget {
  const BaixasHistory({super.key});

  @override
  State<BaixasHistory> createState() => _BaixasHistoryState();
}

class _BaixasHistoryState extends State<BaixasHistory> {
  List? baixas;
  List? estoques;
  bool isLoading = true;

  void getData() async {
    baixas = await FirebaseFirestoreApi.getBaixas(context);
    estoques = await FirebaseFirestoreApi.getEstoques();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorTheme.light,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 0.7,
        child:
            isLoading || estoques == null || baixas == null
                ? Center(
                  child: Loader(color: ColorTheme.secondaryTwo, size: 50),
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text('Histórico de baixas', style: LetterTheme.mainTitle),
                      SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder:
                              (context, index) =>
                                  BaixasTile(estoques!, baixas![index]),
                          itemCount: baixas!.length,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
