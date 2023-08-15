import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';
import '../providers/signup/signup_provider.dart';
import '../utils/error_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const String routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _email, _password;
  final _passwordController = TextEditingController();

  void _submit() async {
    setState(
      () {
        _autovalidateMode = AutovalidateMode.always;
      },
    );

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();

    try {
      await context.read<SignupProvider>().signup(
            name: _name!,
            email: _email!,
            password: _password!,
          );
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<SignupProvider>().state;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                reverse: true,
                shrinkWrap: true,
                children: [
                  Image.asset(
                    'assets/images/flutter_logo.png',
                    height: 250,
                    width: 250,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.abc),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name required';
                      } else if (value.trim().length < 2) {
                        return 'Name has to be longer than 2 chars';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _name = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email required';
                      } else if (!isEmail(
                        value.trim(),
                      )) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _email = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password required';
                      } else if (value.trim().length < 6) {
                        return 'Password must be at least six chars long';
                      } else if (!value.trim().contains(
                            RegExp(r'.*[0-9].*[!@#\$%^&*()_+{}\[\]:;<>,.?~].*'),
                          )) {
                        return 'Password must include a number and a special char';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _password = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if (_passwordController.text != value) {
                        return 'Passwords have to match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed:
                        loginState.signupStatus == SignupStatus.submitting
                            ? null
                            : _submit,
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                        loginState.signupStatus == SignupStatus.submitting
                            ? 'Loading'
                            : 'Sign Up'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed:
                        loginState.signupStatus == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(
                                  context,
                                );
                              },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Already a member? Sign in!',
                    ),
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
