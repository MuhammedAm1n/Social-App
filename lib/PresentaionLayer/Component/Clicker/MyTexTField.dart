// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTEXTFIELD extends StatelessWidget {
  TextEditingController controller;
  String hint;
  bool observer;
  TextInputType? keyboardType;
  MyTEXTFIELD(
      {super.key,
      required this.controller,
      required this.hint,
      required this.observer,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: observer,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
