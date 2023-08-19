import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_firebase/admin.dart';
import 'package:user_firebase/home.dart';
import 'package:user_firebase/input_customize.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  const Edit({super.key, required this.user});

  final dynamic user;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void initState() {
    super.initState();

    emailController.text = widget.user['email'];
    displayNameController.text = widget.user['displayName'] ?? "";
    phoneNumberController.text = widget.user['phoneNumber'] ?? "+66";
    verified = widget.user['emailVerified'];
    disabled = widget.user['disabled'];
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late bool verified;
  late bool disabled;

  void submitForm() {
    http
        .put(
      Uri.parse('http://192.168.48.1:5000/user/${widget.user["uid"]}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'displayName': displayNameController.text,
        'phoneNumber': phoneNumberController.text,
        'password': passwordController.text,
        'emailVerified': verified,
        'disabled': disabled
      }),
    )
        .then((value) {
      if (value.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong please try again later.")));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Edit account successfully.")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 199, 53, 77),
          title: const Text('Edit Account'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                submitForm();
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Column(children: [
          InputCustomizado(
            inputController: emailController,
            hint: 'username',
            obscure: false,
            icon: const Icon(Icons.email),
            enable: false,
          ),
          InputCustomizado(
            inputController: displayNameController,
            hint: 'username',
            obscure: false,
            icon: const Icon(Icons.person),
          ),
          InputCustomizado(
            inputController: phoneNumberController,
            hint: 'phone number',
            obscure: false,
            icon: const Icon(Icons.phone),
          ),
          InputCustomizado(
            inputController: passwordController,
            hint: 'password',
            obscure: false,
            icon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Account verified"),
          Column(children: [
            ListTile(
              title: const Text('verified'),
              leading: Radio(
                value: true,
                groupValue: verified,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      verified = value;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('not verify'),
              leading: Radio(
                value: false,
                groupValue: verified,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      verified = value;
                    });
                  }
                },
              ),
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
          const Text("Account enable"),
          Column(children: [
            ListTile(
              title: const Text('Enable'),
              leading: Radio(
                value: false,
                groupValue: disabled,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      disabled = value;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Disable'),
              leading: Radio(
                value: true,
                groupValue: disabled,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      disabled = value;
                    });
                  }
                },
              ),
            ),
          ])
        ]));
  }
}
