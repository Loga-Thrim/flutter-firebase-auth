import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_firebase/home.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _Verification();
}

class _Verification extends State<Verification> {
  @override
  void initState() {
    super.initState();

    verification();
  }

  bool isEmailVerified = false;
  Timer? timer;

  Future<void> verification() async {
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());

    setState(() {});
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser != null
          ? FirebaseAuth.instance.currentUser!.emailVerified
          : false;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email Successfully Verified")));

      timer?.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Waiting for email verification ...'),
            TextButton(
                onPressed: () {
                  timer?.cancel();
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("Sign out"))
          ],
        )),
      ),
    );
  }
}
