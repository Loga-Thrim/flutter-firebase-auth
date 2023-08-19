
import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key, required this.user});

  final dynamic user;

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 160,
            child: Center(
                child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 40.0,
                    color: const Color.fromARGB(255, 160, 33, 54),
                    child: Center(
                        child: Text(widget.user?.displayName ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)))),
                Container(
                    width: double.infinity,
                    height: 40.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(widget.user?.email ?? "",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16)))),
                Container(
                    width: double.infinity,
                    height: 40.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(widget.user?.phoneNumber ?? "",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16)))),
                Container(
                    width: double.infinity,
                    height: 40.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                            "this account is ${widget.user?.emailVerified == true ? 'verified' : 'not verify'}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 109, 109, 109),
                                fontSize: 14)))),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
