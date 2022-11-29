import 'package:chat_app/Functions/firebase_functions.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:chat_app/refactored_widgets/auth_button.dart';
import 'package:chat_app/refactored_widgets/auth_text_feild.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBoxHeight(50),
                        Image.asset(
                          'assets/chat_app.png',
                          height: 150,
                          width: 150,
                        ),
                        sizedBoxHeight(20),
                        AuthTextFeild(
                          icon: Icons.person,
                          controller: _name,
                          hintText: 'Name',
                          validator: _name.text,
                          validateText: 'please enter a valid name',
                        ),
                        sizedBoxHeight(15),
                        AuthTextFeild(
                          icon: Icons.mail,
                          controller: _email,
                          hintText: 'Email',
                          validator: _email.text,
                          validateText: 'please enter a valid email',
                        ),
                        sizedBoxHeight(15),
                        AuthTextFeild(
                          icon: Icons.lock,
                          controller: _password,
                          hintText: 'Password',
                          validator: _password.text,
                          validateText: 'wrong password',
                          obscureText: true,
                        ),
                        sizedBoxHeight(15),
                        AuthButton(
                            buttonLabel: 'Sign Up',
                            onButtonClicked: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                createAccount(
                                  _name.text,
                                  _email.text,
                                  _password.text,
                                ).then((user) {
                                  if (user != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print('Account created successfully');
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomeScreen()));
                                  } else {
                                    print('Login failed');
                                  }
                                });
                              }
                            }),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Login '),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
