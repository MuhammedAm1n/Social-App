import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';
import 'package:social/PresentaionLayer/Component/Clicker/CustomSnackbar.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyButton.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyTexTField.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController passEditingController = TextEditingController();
  final TextEditingController confirmpassEditingController =
      TextEditingController();
  final TextEditingController usernameEditingController =
      TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: SingleChildScrollView(
            child: Padding(
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
                    const Text(
                      'Social',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MyTEXTFIELD(
                        controller: usernameEditingController,
                        hint: 'Username',
                        observer: false),
                    const SizedBox(height: 15),
                    // TextField Emial
                    MyTEXTFIELD(
                        controller: textEditingController,
                        hint: 'Email',
                        observer: false),
                    const SizedBox(height: 15),
                    //TextField
                    MyTEXTFIELD(
                        controller: passEditingController,
                        hint: 'Password',
                        observer: true),
                    const SizedBox(height: 15),
                    //ConfirmPassword
                    MyTEXTFIELD(
                        controller: confirmpassEditingController,
                        hint: 'Confirm Password',
                        observer: true),
                    const SizedBox(height: 15),

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
                      text: 'Register',
                      onTap: () async {
                        try {
                          await value.CaseRegistUser(
                              textEditingController.text,
                              passEditingController.text,
                              confirmpassEditingController.text,
                              usernameEditingController.text);
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
                          "Already have an account? ",
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                        GestureDetector(
                          onTap: onTap,
                          child: Text(
                            'Login Here',
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
