import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  TextEditingController controller;
  InputField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Color(0xffece5dd),
      ),
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // added line
          mainAxisSize: MainAxisSize.min,
          // added line
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.attach_file,
                color: accentGrey,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.camera_alt,
                color: accentGrey,
              ),
            ),
          ],
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        filled: true,
        fillColor: darkGrey,
        hintStyle: const TextStyle(
          color: accentGrey,
        ),
        hintText: 'Nachricht',
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 10.0),
      ),
    );
  }
}
