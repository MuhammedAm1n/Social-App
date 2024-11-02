import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/PresentaionLayer/Screens/MessagePage.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Messages"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
// errors
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.data}');
            }

//loading screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
// Null data
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

// get all users
            final users = snapshot.data!.docs.asMap();
            final FirebaseAuth auth = FirebaseAuth.instance;
            if (auth.currentUser!.email != users['email']) {
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
// get individual user
                    final User = users[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15)),
                        height: 100,
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagePage(
                                            reciverUserEmail: User['username'],
                                            reciverId: User['uid'],
                                          )));
                            },
                            title: Text(
                              User!['username'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(User['email']),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Text('s');
          }),
    );
  }
}
