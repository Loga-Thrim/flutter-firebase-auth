import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_firebase/admin.dart';
import 'package:user_firebase/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic user;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  Future<void> getUser() async {
    user = await FirebaseAuth.instance.currentUser;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 199, 53, 77),
        title: const Text('Manage Account'),
        actions: <Widget>[
          TextButton(
            child:
                const Text('Sign out', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: user?.email == 'admin@gmail.com'
            ? const Admin()
            : UserAccount(user: user),
      ),
    );
  }
}
