import 'package:flutter/material.dart';

class CostumTxtfield extends StatelessWidget {
  const CostumTxtfield({super.key, this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: const Color.fromARGB(137, 255, 255, 255),
      cursorRadius: Radius.circular(20),
      controller: controller,
      cursorHeight: 20,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        hintText: 'Ask Anything..',
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            bottomLeft: Radius.circular(80),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 0.5,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            bottomLeft: Radius.circular(80),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
