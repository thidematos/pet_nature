import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/screens/loading_screen.dart';
import 'package:pet_nature/screens/produtos_screen.dart';
import 'package:pet_nature/screens/start_screen.dart';
import 'package:pet_nature/screens/tabs_screen.dart';
import 'package:pet_nature/services/firebase_auth_api.dart';
import 'package:pet_nature/themes/geral_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Nature',
      theme: theme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          if (snapshot.data != null) {
            return TabsScreen();
          }

          return StartScreen();
        },
      ),
    );
  }
}
