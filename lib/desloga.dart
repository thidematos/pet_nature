import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Desloga extends StatelessWidget {
  const Desloga();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('desloga'),
          ),
        ),
      ),
    );
  }
}
