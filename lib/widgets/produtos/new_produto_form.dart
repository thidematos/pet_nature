import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/global_data.dart';
import 'package:pet_nature/providers/produtos_provider.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/services/firebase_storage_api.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/dropdown.dart';
import 'package:pet_nature/widgets/ui/image_input.dart';
import 'package:pet_nature/widgets/ui/input.dart';

class NewProdutoForm extends ConsumerStatefulWidget {
  const NewProdutoForm({super.key});

  @override
  ConsumerState<NewProdutoForm> createState() => _NewProdutoFormState();
}

class _NewProdutoFormState extends ConsumerState<NewProdutoForm> {
  String selectedCategory = 'racao';
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController brandController = TextEditingController(text: '');
  final TextEditingController descriptionController = TextEditingController(
    text: '',
  );
  File? pickedImage;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  void onSelectCategory(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  void onPickImage(File image) {
    setState(() {
      pickedImage = image;
    });
  }

  String? validate(value, field) {
    if (value!.isEmpty) return 'Adicione um nome para o $field';

    return null;
  }

  void submit() async {
    final bool isValidate = formKey.currentState!.validate();

    if (!isValidate) return;

    if (pickedImage == null) {
      UiInstances.showSnackbar(context, 'Adicione uma foto do produto!');
      return;
    }

    final int now = DateTime.now().millisecondsSinceEpoch;

    final String uid = kUuid.v4();

    setState(() {
      isLoading = true;
    });

    final imageUrl = await FirebaseStorageApi.uploadProdutoImage(
      pickedImage!,
      uid,
    );

    final produtoData = {
      'name': nameController.text,
      'category': selectedCategory,
      'description': descriptionController.text,
      'brand': brandController.text,
      'created_at': now,
      'uid': uid,
      'image': imageUrl,
      'last_edition': {
        'timestamp': now,
        'user': FirebaseAuth.instance.currentUser!.uid,
      },
    };

    final isOkay = await FirebaseFirestoreApi.createProduto(
      context,
      produtoData,
    );

    setState(() {
      isLoading = false;
    });

    if (!isOkay) return;

    ref.invalidate(ProdutosProvider);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          ImageInput(pickedImage, onPickImage, useCamera: false),
          Input(
            useAutoCapitalization: true,
            placeholder: 'Ração cachorro 20kg grande porte Lester',
            label: 'Nome do produto*',
            controller: nameController,
            validator: (value) => validate(value, 'produto'),
          ),
          Dropdown(
            'Categoria*',
            items: kProdutosCategories,
            defaultValue: selectedCategory,
            onChange: onSelectCategory,
          ),
          Input(
            placeholder: 'Lester',
            label: 'Marca*',
            controller: brandController,
            useAutoCapitalization: true,
            validator: (value) => validate(value, 'marca'),
          ),
          Input(
            useAutoCapitalization: true,
            placeholder: 'Produto recomendado para...',
            label: 'Descrição',
            controller: descriptionController,
            minLines: 3,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Button('Salvar produto', submit, isLoading: isLoading),
              ),
              Flexible(flex: 1, child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
