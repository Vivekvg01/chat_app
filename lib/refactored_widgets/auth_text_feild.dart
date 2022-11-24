import 'package:chat_app/const_values/const_values.dart';
import 'package:flutter/material.dart';

class AuthTextFeild extends StatelessWidget {
  AuthTextFeild({
    Key? key,
    required this.icon,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.validateText,
    this.obscureText = false,
  }) : super(key: key);

  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final String validator;
  final String validateText;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          sizedBoxWidth(15),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 23,
            ),
          ),
          sizedBoxWidth(10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 8,
              ),
              child: TextFormField(
                maxLines: 1,
                validator: (validator) {
                  if (validator == null || validator.isEmpty) {
                    return validateText;
                  } else {
                    return null;
                  }
                },
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 1),
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
