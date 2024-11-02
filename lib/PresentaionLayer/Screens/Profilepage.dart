import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
        ),
        body: Consumer<UseCases>(
          builder: (context, value, child) =>
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: value.CaseGetUserDetails(),
                  builder: (context, snapshot) {
                    // loading..
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.data}");
                    } else if (snapshot.hasData) {
                      Map<String, dynamic>? user = snapshot.data!.data();
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Profile pic

                            Container(
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 65,
                                  ),
                                )),

                            const SizedBox(
                              height: 35,
                            ),
                            //userName
                            Text(
                              user!['username'],
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //email
                            Text(
                              user['email'],
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text('nodata');
                    }
                  }),
        ));
  }
}
