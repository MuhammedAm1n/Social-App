// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyButton.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyTexTField.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Consumer<UseCases>(
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.person,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                //Text
                Text(
                  'Social',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // TextField Emial
                MyTEXTFIELD(
                    controller: _textEditingController,
                    hint: 'Email',
                    observer: false),
                SizedBox(height: 15),
                //TextField
                MyTEXTFIELD(
                    controller: _passEditingController,
                    hint: 'Password',
                    observer: true),
                //Text
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                // Button
                MyButton(
                  text: 'Login',
                  onTap: () async {
                    await value.CaseLoginUser(_textEditingController.text,
                        _passEditingController.text);
                  },
                )

                //Text
                ,
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Here',
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
