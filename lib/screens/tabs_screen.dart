import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/providers/tab_provider.dart';
import 'package:pet_nature/screens/estoque_screen.dart';
import 'package:pet_nature/screens/loading_screen.dart';
import 'package:pet_nature/screens/perfil_screen.dart';
import 'package:pet_nature/screens/produtos_screen.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  final List<Widget> pages = [
    PerfilScreen(),
    ProdutosScreen(),
    EstoqueScreen(),
  ];

  bool isLoading = true;

  getUser() async {
    await Future.delayed(Duration(seconds: 5), () async {
      final user = await FirebaseFirestoreApi.verifyUser();
      ref.read(UserProvider.notifier).setUser(user);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentTab = ref.watch(TabProvider);

    final actualContent = pages[currentTab];

    if (isLoading) {
      return LoadingScreen();
    }

    return Scaffold(
      appBar: UiInstances.appBar(
        ref.read(TabProvider.notifier).goToProfile,
        useHistory: currentTab == 2 ? true : false,
        context: currentTab == 2 ? context : null,
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        child: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: ref.read(TabProvider.notifier).changeActiveTab,
          iconSize: 25,
          backgroundColor: ColorTheme.secondaryTwo,
          selectedLabelStyle: LetterTheme.textSemibold,
          selectedItemColor: ColorTheme.light,
          unselectedItemColor: ColorTheme.light,
          items: [
            BottomNavigationBarItem(
              icon: Icon(currentTab == 0 ? Icons.person : Icons.person_outline),
              label: 'PERFIL',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentTab == 1
                    ? Icons.local_offer
                    : Icons.local_offer_outlined,
              ),
              label: 'PRODUTOS',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentTab == 2 ? Icons.inventory : Icons.inventory_2_outlined,
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
  }
}
