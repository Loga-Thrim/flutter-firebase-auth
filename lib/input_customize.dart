import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {
  const InputCustomizado({
    super.key,
    required this.hint,
    this.obscure = false,
    this.icon = const Icon(Icons.person),
    required this.inputController,
    this.enable = true
  });

  final String hint;
  final bool obscure;
  final Icon icon;
  final TextEditingController inputController;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextField(
        enabled: enable,
        controller: inputController,
        obscureText: obscure,
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}