import 'package:chat_app/Functions/auth_functions.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:chat_app/refactored_widgets/auh_button.dart';
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
  final _formKey = GlobalKey<FormState>();
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
                    child: Form(
                      key: _formKey,
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
                            validator: _email.text,
                            validateText: 'Please enter a valid email',
                          ),
                          sizedBoxHeight(15),
                          AuthTextFeild(
                            icon: Icons.lock,
                            controller: _password,
                            hintText: 'Password',
                            validator: _password.text,
                            validateText: 'Wrong password',
                            obscureText: true,
                          ),
                          sizedBoxHeight(20),
                          AuthButton(
                            buttonLabel: 'Login',
                            onButtonClicked: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                login(_email.text, _password.text).then((user) {
                                  if (user != null) {
                                    print('Login Successful');
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushReplacement(
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
                          ),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: const Text('Login'),
                          // ),
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
      ),
    );
  }
}
