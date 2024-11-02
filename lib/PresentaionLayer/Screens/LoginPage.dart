// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';
import 'package:social/PresentaionLayer/Component/Clicker/CustomSnackbar.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyButton.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyTexTField.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Consumer<UseCases>(
            builder: (context, value, child) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  // Logo
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  //Text
                  const Text(
                    'Social',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // TextField Emial
                  MyTEXTFIELD(
                      controller: _textEditingController,
                      hint: 'Email',
                      observer: false),
                  const SizedBox(height: 15),
                  //TextField
                  MyTEXTFIELD(
                      controller: _passEditingController,
                      hint: 'Password',
                      observer: true),
                  //Text
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Button
                  MyButton(
                    text: 'Login',
                    onTap: () async {
                      try {
                        await value.CaseLoginUser(
                          _textEditingController.text,
                          _passEditingController.text,
                        );
                      } catch (e) {
                        CustomSnackbar.showSnackbar(context, e.toString());
                      }
                    },
                  )

                  //Text
                  ,
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register Here',
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
