import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';
import '../providers/login/login_provider.dart';
import '../utils/error_dialog.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/signin';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

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
      await context.read<LoginProvider>().login(
            email: _email!,
            password: _password!,
          );
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginProvider>().state;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
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
                              RegExp(
                                  r'.*[0-9].*[!@#\$%^&*()_+{}\[\]:;<>,.?~].*'),
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
                    ElevatedButton(
                      onPressed:
                          loginState.loginStatus == LoginStatus.submitting
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
                          loginState.loginStatus == LoginStatus.submitting
                              ? 'Loading'
                              : 'Sign In'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed:
                          loginState.loginStatus == LoginStatus.submitting
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    SignupPage.routeName,
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
                        'Not a member? Sign up!',
                      ),
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
