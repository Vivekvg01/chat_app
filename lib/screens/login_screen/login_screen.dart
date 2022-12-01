import 'package:chat_app/Functions/firebase_functions.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:chat_app/refactored_widgets/auth_button.dart';
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

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

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
                          Container(
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
                                  child: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 23,
                                  ),
                                ),
                                sizedBoxWidth(10),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: _passwordVisible,
                                    controller: _password,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: _passwordVisible
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          sizedBoxHeight(20),
                          //Login button
                          AuthButton(
                            buttonLabel: 'Login',
                            onButtonClicked: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                logIn(_email.text, _password.text).then((user) {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Sign up'),
                              ),
                            ],
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
