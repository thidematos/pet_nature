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
import 'package:pet_nature/widgets/ui/confirm_password.dart';
import 'package:pet_nature/widgets/ui/dropdown.dart';
import 'package:pet_nature/widgets/ui/image_input.dart';
import 'package:pet_nature/widgets/ui/input.dart';

class EditProdutoForm extends ConsumerStatefulWidget {
  const EditProdutoForm(this.produto, {super.key});

  final Map produto;

  @override
  ConsumerState<EditProdutoForm> createState() => _EditProdutoFormState();
}

class _EditProdutoFormState extends ConsumerState<EditProdutoForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  File? image;
  String selectedCategory = '';

  void onPickImage(File pickedImage) {
    setState(() {
      image = pickedImage;
    });
  }

  void onSelectCategory(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  String? validator(String? value, String field) {
    if (value == null || value.isEmpty) return 'Adicione $field!';

    return null;
  }

  void submit() async {
    final bool isValidated = formKey.currentState!.validate();

    if (!isValidated) return;

    final updateData = {
      'name': nameController.text,
      'brand': brandController.text,
      'category': selectedCategory,
      'description': descriptionController.text,
      'last_edition': {
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'user': FirebaseAuth.instance.currentUser!.uid,
      },
    };

    setState(() {
      isLoading = true;
    });

    if (image != null) {
      String imageUrl = await FirebaseStorageApi.updateProdutoImage(
        image!,
        widget.produto['uid'],
      );

      updateData.addAll({'image': imageUrl});
    }

    final bool isAllGood = await FirebaseFirestoreApi.updateProduto(
      context,
      updateData,
      widget.produto['uid'],
    );

    setState(() {
      isLoading = false;
    });

    if (isAllGood) {
      ref.invalidate(ProdutosProvider);
      Navigator.of(context).pop();
    }
  }

  void deleteProduto() async {
    final String? result = await showDialog(
      context: context,
      builder: (context) => ConfirmPassword('Excluir'),
    );

    if (result == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final List estoques = await FirebaseFirestoreApi.getEstoques();

    final curEstoque =
        estoques
            .where((estoque) => estoque['produto'] == widget.produto['uid'])
            .toList();

    if (curEstoque.isNotEmpty) {
      UiInstances.showSnackbar(context, 'Produto em estoque!');
      setState(() {
        isLoading = false;
      });
      return;
    }

    final bool isOkay = await FirebaseFirestoreApi.deleteProduto(
      context,
      widget.produto['uid'],
    );

    setState(() {
      isLoading = false;
    });

    if (isOkay) {
      ref.invalidate(ProdutosProvider);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    nameController.value = TextEditingValue(text: widget.produto['name']);
    brandController.value = TextEditingValue(text: widget.produto['brand']);
    descriptionController.value = TextEditingValue(
      text: widget.produto['description'],
    );
    selectedCategory = widget.produto['category'];
    super.initState();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageInput(
            radius: 50,
            image,
            label: 'Alterar imagem',
            onPickImage,
            useLastImage: widget.produto['image'],
            useCamera: false,
          ),
          Input(
            placeholder: 'Ração Lester',
            label: 'Nome do produto*',
            controller: nameController,
            useAutoCapitalization: true,
            validator: (value) => validator(value, 'um nome do produto!'),
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
            validator: (value) => validator(value, 'uma marca!'),
          ),
          Input(
            placeholder: 'Recomendado para...',
            label: 'Descrição',
            controller: descriptionController,
            useAutoCapitalization: true,
          ),
          SizedBox(height: 24),
          Row(
            spacing: 24,
            children: [
              Flexible(
                flex: 2,
                child: Button(
                  'Salvar informações',
                  submit,
                  isLoading: isLoading,
                ),
              ),
              Flexible(
                flex: 1,
                child: Button(
                  'Excluir',
                  deleteProduto,
                  isDanger: true,
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
