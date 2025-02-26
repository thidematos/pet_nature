import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/screens/estoque_screen.dart';
import 'package:pet_nature/screens/loading_screen.dart';
import 'package:pet_nature/screens/perfil_screen.dart';
import 'package:pet_nature/screens/produtos_screen.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPage = 1;

  final List<Widget> pages = [
    PerfilScreen(),
    ProdutosScreen(),
    EstoqueScreen(),
  ];

  void selectTab(int page) {
    setState(() {
      selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final actualContent = pages[selectedPage];

    final data = ref.watch(AuthProvider);

    return data.when(
      loading: () => LoadingScreen(),
      error: (error, stackTrace) => Text('Algo deu errado!'),
      data: (data) {
        return Scaffold(
          appBar: UiInstances.appBar,
          bottomNavigationBar: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              currentIndex: selectedPage,
              onTap: selectTab,
              iconSize: 25,
              backgroundColor: ColorTheme.secondaryTwo,
              selectedLabelStyle: LetterTheme.textSemibold,
              selectedItemColor: ColorTheme.light,
              unselectedItemColor: ColorTheme.light,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedPage == 0 ? Icons.person : Icons.person_outline,
                  ),
                  label: 'PERFIL',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedPage == 1
                        ? Icons.local_offer
                        : Icons.local_offer_outlined,
                  ),
                  label: 'PRODUTOS',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedPage == 2
                        ? Icons.inventory
                        : Icons.inventory_2_outlined,
                  ),
                  label: 'ESTOQUE',
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
            child: actualContent,
          ),
        );
      },
    );
  }
}
