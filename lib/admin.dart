import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_firebase/edit_form.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  List<dynamic> _users = [];
  Future<void> fetchUsers() async {
    http.get(Uri.parse('http://192.168.48.1:5000/users')).then((data) {
      if (data.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Can not fetch users.")));
        return;
      }
      var users = jsonDecode(data.body);

      setState(() {
        _users = users;
      });
    });
  }

  void deleteUser(String uid) {
    http.delete(Uri.parse('http://192.168.48.1:5000/user/${uid}')).then((data) {
      if (data.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong please try again later.")));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Deleted account successfully.")));
      fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var user in _users)
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 200,
                  child: Center(
                      child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 40.0,
                          color: const Color.fromARGB(255, 160, 33, 54),
                          child: Center(
                              child: Text(user['displayName'] ?? "",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)))),
                      Container(
                          width: double.infinity,
                          height: 40.0,
                          color: Colors.white,
                          child: Center(
                              child: Text(user['email'] ?? "",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16)))),
                      Container(
                          width: double.infinity,
                          height: 40.0,
                          color: Colors.white,
                          child: Center(
                              child: Text(user['phoneNumber'] ?? "",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16)))),
                      Container(
                          width: double.infinity,
                          height: 40.0,
                          color: Colors.white,
                          child: Center(
                              child: Text(
                                  "this account is ${user['emailVerified'] == true ? 'verified' : 'not verify'}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 109, 109, 109),
                                      fontSize: 14)))),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Edit(user: user)),
                                    );
                                  },
                                  child: const Text("Edit account",
                                      style: TextStyle(color: Colors.green))),
                              TextButton(
                                  onPressed: () {
                                    if (user['email'] == 'admin@gmail.com') {
                                      return;
                                    }
                                    deleteUser(user['uid']);
                                  },
                                  child: Text("Delete account",
                                      style: TextStyle(
                                          color:
                                              user['email'] == 'admin@gmail.com'
                                                  ? const Color.fromARGB(
                                                      255, 139, 139, 139)
                                                  : Colors.red)))
                            ]),
                      )
                    ],
                  )),
                ),
              ),
            ),
          )
      ],
    );
  }
}
