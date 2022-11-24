import 'package:chat_app/Functions/auth_functions.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:chat_app/refactored_widgets/auth_text_feild.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import '../sign_up_screen/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/chat_app.png',
                          height: 150,
                          width: 150,
                        ),
                        sizedBoxHeight(10),
                        AuthTextFeild(
                          icon: Icons.mail,
                          controller: _email,
                          hintText: 'Email',
                          validator: 'validator',
                          validateText: 'validateText',
                        ),
                        sizedBoxHeight(15),
                        AuthTextFeild(
                          icon: Icons.lock,
                          controller: _password,
                          hintText: 'Password',
                          validator: 'validator',
                          validateText: 'validateText',
                          obscureText: true,
                        ),
                        sizedBoxHeight(15),
                        ElevatedButton(
                          onPressed: () {
                            if (_email.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              login(_email.text, _password.text).then((user) {
                                if (user != null) {
                                  print('Login Successful');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(),
                                    ),
                                  );
                                } else {
                                  print('Login Failed');
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            } else {
                              print('Please add all informations');
                            }
                          },
                          child: const Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: const Text('Create Account'),
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
