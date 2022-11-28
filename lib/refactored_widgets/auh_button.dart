import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonLabel;
  final Function onButtonClicked;

  const AuthButton({
    Key? key,
    required this.buttonLabel,
    required this.onButtonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 300,
      child: ElevatedButton(
        onPressed: () {
          onButtonClicked();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(buttonLabel),
      ),
    );
  }
}
